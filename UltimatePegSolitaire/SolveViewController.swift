//
//  SolveViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/3/19.
//  Copyright © 2019 Maksim Khrapov. All rights reserved.
//

// https://www.ultimatepegsolitaire.com/
// https://github.com/mkhrapov/ultimate-peg-solitaire
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import UIKit

final class SolveViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pruningNumberLabelButton: UIButton!
    @IBOutlet weak var timeOutLabelButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var solveButton: UIButton!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var resultsTextLabel: UILabel!
    
    
    
    
    
    
    
    var gameState: GameState?
    var elapsedTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        
        navigationItem.title = "Solve"
        let backItem = UIBarButtonItem()
        backItem.title = "Solve"
        navigationItem.backBarButtonItem = backItem
        
        solveButton.layer.cornerRadius = 10
        solveButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        
        resultsTextLabel.lineBreakMode = .byWordWrapping
        resultsTextLabel.numberOfLines = 0
        setResultsTextLabel()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let gameState = gameState {
            let pruningNumber = String(gameState.board.pruningNumber) + " ➤"
            let timeOut = TimeOut.shared.title(gameState.timeOut) + " ➤"
            
            pruningNumberLabelButton.setTitle(pruningNumber, for: .normal)
            timeOutLabelButton.setTitle(timeOut, for: .normal)
        }
    }
    
 
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
    }
    
    
    
    @IBAction func solveButtonAction(_ sender: UIButton) {
        if let gameState = gameState {
            gameState.board.complementary = false
            gameState.board.timeToSolveSeconds = 0.0
            gameState.board.solution = nil
            resultsTextLabel.attributedText = nil
            resultsTextLabel.text = "Searching..."
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
                let p = gameState.board.initialPosition()
                let pruningSearch = PruningSearch(p)
                pruningSearch.prune(gameState.board.pruningNumber)
                
                self.startElapsedTimer()
                let start = DispatchTime.now()
                let numSolutions = pruningSearch.search()
                let end = DispatchTime.now()
                self.elapsedTimerRunning = false
                let timer = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/1_000_000_000.0
                
                if numSolutions > 0 {
                    var complementary = false
                    var history: [Move]?
                    
                    for i in 0..<numSolutions {
                        let p1 = pruningSearch.getSolution(i)
                        if p1.isComplement(p) {
                            complementary = true
                            history = p1.history
                            break
                        }
                    }
                    
                    if !complementary {
                        history = pruningSearch.getSolution(0).history
                    }
                    
                    DispatchQueue.main.async {
                        gameState.board.complementary = complementary
                        gameState.board.solution = history
                        gameState.board.timeToSolveSeconds = timer
                        self.setResultsTextLabel()
                        BoardManager.shared.persist()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        gameState.board.timeToSolveSeconds = timer
                        self.setResultsTextLabel()
                        BoardManager.shared.persist()
                    }
                }
            }
        }
    }
    
    
    func setResultsTextLabel() {
        resultsTextLabel.attributedText = nil
        
        if let gameState = gameState {
            let time = String(format: "%.2f", gameState.board.timeToSolveSeconds)
            
            if let _ = gameState.board.solution {
                let prefix = gameState.board.complementary ? "Complementary" : "A"
                resultsTextLabel.text = "\(prefix) solution has been found in \(time) sec."
            }
            else {
                if gameState.board.timeToSolveSeconds > 0.0 {
                    resultsTextLabel.text = "No solution has been found in \(time) sec."
                }
                else {
                    resultsTextLabel.text = "Click Solve Button to start solving."
                }
            }
        }
        else {
            resultsTextLabel.text = "Click Solve Button to start solving."
        }
    }
    
    
    func setError(_ text: String) {
        resultsTextLabel.text = nil
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red]
        resultsTextLabel.attributedText = NSAttributedString(string: text, attributes: attrs)
    }
    
    
    func startElapsedTimer() {
        self.elapsedTimerRunning = true
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
            let start = DispatchTime.now()
            var text = ""
            while self.elapsedTimerRunning {
                let current = DispatchTime.now()
                let elapsedTime = Int(Double(current.uptimeNanoseconds - start.uptimeNanoseconds)/1_000_000_000.0)
                let sec = elapsedTime % 60
                let min = elapsedTime / 60
                if min == 0 {
                    text = String(sec) + " sec"
                }
                else {
                    text = String(min) + " m " + String(sec) + " s"
                }
                
                DispatchQueue.main.async {
                    self.elapsedTimeLabel.text = text
                }
                
                Thread.sleep(forTimeInterval: 1.0)
            }
        }
    }
}

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

final class SolveViewController: UIViewController {

    
    @IBOutlet weak var pruningNumberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var solveButton: UIButton!
    
    var gameState: GameState?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Solve"
        let backItem = UIBarButtonItem()
        backItem.title = "Solve"
        navigationItem.backBarButtonItem = backItem
        
        solveButton.layer.cornerRadius = 10
        solveButton.clipsToBounds = true
        
        gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        setResultsLabel()
        setPruningNumberTextField()
    }
    
    
    func setResultsLabel() {
        resultLabel.attributedText = nil
        
        if let gameState = gameState {
            let time = String(format: "%.2f", gameState.board.timeToSolveSeconds)
            
            if let _ = gameState.board.solution {
                let prefix = gameState.board.complementary ? "Complementary" : "A"
                resultLabel.text = "\(prefix) solution has been found in \(time) sec."
            }
            else {
                if gameState.board.timeToSolveSeconds > 0.0 {
                    resultLabel.text = "No solution has been found in \(time) sec. Try using a larger pruning number."
                }
                else {
                    resultLabel.text = "No solution has been found in \(time) sec."
                }
            }
        }
        else {
            resultLabel.text = ""
        }
    }
    
    
    func setPruningNumberTextField() {
        if let gameState = gameState {
            let pruningNumber = gameState.board.pruningNumber
            pruningNumberTextField.text = "\(pruningNumber)"
        }
        else {
            pruningNumberTextField.text = "200"
        }
    }
    
    
    func setError(_ text: String) {
        resultLabel.text = nil
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red]
        resultLabel.attributedText = NSAttributedString(string: text, attributes: attrs)
    }
    
    
    @IBAction func solveButtonAction(_ sender: UIButton) {
        if let gameState = gameState,
           let text = pruningNumberTextField.text,
           let pruningNumber = Int(text),
           pruningNumber > 0 && pruningNumber <= 10_000
        {
            // TODO persist
            gameState.board.pruningNumber = pruningNumber
            activityIndicator.startAnimating()
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
                
                let p = gameState.board.initialPosition()
                let pruningSearch = PruningSearch(p)
                pruningSearch.prune(pruningNumber)
                
                // TODO timer
                let numSolutions = pruningSearch.search()
                let timer = 0.0
                // TODO TIMER
                
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
                        self.setResultsLabel()
                        self.activityIndicator.stopAnimating()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        gameState.board.timeToSolveSeconds = timer
                        self.setResultsLabel()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        else {
            setError("Pruning number must be an integer between 1 and 10000")
        }
    }
}

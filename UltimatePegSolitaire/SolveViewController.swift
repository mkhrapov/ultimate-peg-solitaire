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
    
    var gameState: GameState?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Solve"
        let backItem = UIBarButtonItem()
        backItem.title = "Solve"
        navigationItem.backBarButtonItem = backItem
        
        gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        setResultsLabel()
        setPruningNumberTextField()
    }
    
    
    func setResultsLabel() {
        if let gameState = gameState, let _ = gameState.board.solution {
            let time = gameState.board.timeToSolveSeconds
            let prefix = gameState.board.complementary ? "Complementary" : "A"
            resultLabel.text = "\(prefix) solution has been found in \(time) sec"
        }
        else {
            resultLabel.text = "No solution has been found in 0.0 sec"
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
    
    
    
    
    
    @IBAction func solveButton(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

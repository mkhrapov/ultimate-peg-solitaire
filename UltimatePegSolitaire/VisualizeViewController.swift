//
//  VisualizeViewController.swift
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

final class VisualizeViewController: UIViewController {

    @IBOutlet weak var visualizeBoardView: VisualizeBoardView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Visualize"
        let backItem = UIBarButtonItem()
        backItem.title = "Visualize"
        navigationItem.backBarButtonItem = backItem
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        
        visualizeBoardView.gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        
        if let gameState = visualizeBoardView.gameState {
            if gameState.solution == nil {
                gameState.resetVisualization()
            }
        }
        
    }
    
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        if let gameState = visualizeBoardView.gameState {
            gameState.resetVisualization()
            visualizeBoardView.setNeedsDisplay()
        }
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let gameState = visualizeBoardView.gameState {
            if gameState.board.solution == nil {
                let alert = UIAlertController(title: "No Solution", message: "You may want to go to the previous screen and run the solver.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                gameState.next()
                visualizeBoardView.setNeedsDisplay()
            }
        }
    }
    
    
}

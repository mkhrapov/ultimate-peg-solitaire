//
//  PlayViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 10/31/19.
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

final class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = GlobalStateManager.shared.currentPlayingBoardName ?? "Play"

        navigationItem.title = title
        let backItem = UIBarButtonItem()
        backItem.title = title
        navigationItem.backBarButtonItem = backItem
        
        newGameButton.layer.cornerRadius = 10
        newGameButton.clipsToBounds = true
        undoButton.layer.cornerRadius = 10
        undoButton.clipsToBounds = true
        
        boardView.gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
    }
    

    @IBAction func newGameAction(_ sender: UIButton) {
        boardView.gameState = GlobalStateManager.shared.replaceCurrentPlayingBoard()
        boardView.setNeedsDisplay()
    }
    
    
    @IBAction func undoAction(_ sender: UIButton) {
        boardView.gameState?.undo()
        boardView.setNeedsDisplay()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let loc = touch.location(in: boardView)
        
        if loc.x < 0 || loc.y < 0 || loc.x > boardView.bounds.width || loc.y > boardView.bounds.height {
            return
        }
        
        if let (x, y) = boardView.decipher(loc.x, loc.y) {
            boardView.gameState?.touch(x, y)
            boardView.setNeedsDisplay()
        }
    }
    
}

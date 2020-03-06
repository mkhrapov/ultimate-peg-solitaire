//
//  EditInitialPositionViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 3/6/20.
//  Copyright © 2020 Maksim Khrapov. All rights reserved.
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

class EditInitialPositionViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editView: EditInitialPositionView!
    
    var board: Board?
    var initX = 0
    var initY = 0
    var solvable: [Bool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let name = GlobalStateManager.shared.currentPlayingBoardName ?? "Unknown"
        navigationItem.title = "Edit " + name
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        board = BoardManager.shared.getBoardByName(name)
        
        if let board = board {
            initX = board.initX
            initY = board.initY
            
            let solver = SolvablePositions(board)
            if solver.noErrors() {
                solvable = solver.calculateSolvablePositions()
            }
            
            editView.board = board
            editView.initX = initX
            editView.initY = initY
            editView.solvable = solvable
        }
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        guard let board = board else {
            return
        }
        
        if !(initX == board.initX  &&  initY == board.initY) {
            board.initX = initX
            board.initY = initY
            BoardManager.shared.persist()
            
            GlobalStateManager.shared.games[board.name] = nil
            GlobalStateManager.shared.boardImages[board.name] = nil
        }
        
        self.performSegue(withIdentifier: "segueAfterEditingInitialPosition", sender: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        guard let board = board else {
            return
        }
        
        guard let solvable = solvable else {
            return
        }
        
        let loc = touch.location(in: editView)
        
        if loc.x < 0 || loc.y < 0 || loc.x > editView.bounds.width || loc.y > editView.bounds.height {
            return
        }
        
        if let (x, y) = editView.decipher(loc.x, loc.y) {
            let X = board.X
            let i = y*X + x
            
            if solvable[i] {
                initX = x
                initY = y
                
                editView.initX = x
                editView.initY = y
                editView.setNeedsDisplay()
            }
        }
    }
}

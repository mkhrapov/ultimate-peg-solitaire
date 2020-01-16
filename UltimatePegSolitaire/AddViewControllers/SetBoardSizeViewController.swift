//
//  BoardSizeViewController.swift
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

final class SetBoardSizeViewController: UIViewController {

    @IBOutlet weak var boardSizeView: SetBoardSizeView!
    @IBOutlet weak var rowsStepper: UIStepper!
    @IBOutlet weak var columnsStepper: UIStepper!
    @IBOutlet weak var rowsLabel: UILabel!
    @IBOutlet weak var columnsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Set Board Size"
        let backItem = UIBarButtonItem()
        backItem.title = "Board Size"
        navigationItem.backBarButtonItem = backItem
        
        boardSizeView.rows = GlobalStateManager.shared.newBoard.Y
        boardSizeView.columns = GlobalStateManager.shared.newBoard.X
        
        rowsLabel.text = "Rows: \(boardSizeView.rows)"
        columnsLabel.text = "Columns: \(boardSizeView.columns)"
        
        rowsStepper.minimumValue = 4.0
        rowsStepper.maximumValue = 12.0
        rowsStepper.stepValue = 1.0
        rowsStepper.value = Double(boardSizeView.rows)
        
        columnsStepper.minimumValue = 4.0
        columnsStepper.maximumValue = 12.0
        columnsStepper.stepValue = 1.0
        columnsStepper.value = Double(boardSizeView.columns)
    }
    
    
    @IBAction func rowsStepperAction(_ sender: UIStepper) {
        let rows = Int(floor(sender.value))
        boardSizeView.rows = rows
        boardSizeView.setNeedsDisplay()
        rowsLabel.text = "Rows: \(boardSizeView.rows)"
        setNewBoard()
    }
    
    
    @IBAction func columnsStepperAction(_ sender: UIStepper) {
        let columns = Int(floor(sender.value))
        boardSizeView.columns = columns
        boardSizeView.setNeedsDisplay()
        columnsLabel.text = "Columns: \(boardSizeView.columns)"
        setNewBoard()
    }
    
    
    private func setNewBoard() {
        let x = boardSizeView.columns
        let y = boardSizeView.rows
        let allowed = Array(repeating: 1, count: x*y)
        GlobalStateManager.shared.solvable = nil
        GlobalStateManager.shared.newBoard = Board(x, y, 0, 0, "New Board", allowed)
    }
    
}

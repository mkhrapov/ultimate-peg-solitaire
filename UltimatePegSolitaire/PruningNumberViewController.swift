//
//  PruningNumberViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 4/8/20.
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

final class PruningNumberViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var pruningNumberPickerView: UIPickerView!
    
    var gameState: GameState?
    static let allowedPruningNumbers = [100, 200, 300, 400, 500, 750, 1000]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Pruning Number"
        gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        
        self.pruningNumberPickerView.delegate = self
        self.pruningNumberPickerView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let gameState = gameState else {
            return
        }
        
        let currentPruningNumber = gameState.board.pruningNumber
        let rowID = convertPruningNumberToRow(currentPruningNumber)
        
        pruningNumberPickerView.selectRow(rowID, inComponent: 0, animated: true)
    }
    

    func convertPruningNumberToRow(_ pn: Int) -> Int {
        for i in 0..<PruningNumberViewController.allowedPruningNumbers.count {
            if pn == PruningNumberViewController.allowedPruningNumbers[i] {
                return i
            }
        }
        return 0
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PruningNumberViewController.allowedPruningNumbers.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(PruningNumberViewController.allowedPruningNumbers[row])
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gameState = gameState else {
            return
        }
        
        gameState.board.pruningNumber = PruningNumberViewController.allowedPruningNumbers[row]
    }
}

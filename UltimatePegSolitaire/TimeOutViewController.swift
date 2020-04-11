//
//  TimeOutViewController.swift
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

class TimeOutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var timeOutPickerView: UIPickerView!
    
    var gameState: GameState?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Time Out"
        gameState = GlobalStateManager.shared.getCurrentPlayingBoard()
        
        self.timeOutPickerView.delegate = self
        self.timeOutPickerView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let gameState = gameState else {
            return
        }
        
        let row = TimeOut.shared.row(gameState.timeOut)
        timeOutPickerView.selectRow(row, inComponent: 0, animated: true)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TimeOut.shared.allowedTimeOuts.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(TimeOut.shared.allowedTimeOutTitles[row])
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gameState = gameState else {
            return
        }
        
        gameState.timeOut = TimeOut.shared.allowedTimeOuts[row]
    }
}

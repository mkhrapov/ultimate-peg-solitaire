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
    static let allowedTimeOuts = [60, 2*60, 3*60, 5*60, 10*60, 15*60, 30*60, 60*60]
    static let allowedTimeOutTitles = ["60 sec", "2 min", "3 min", "5 min", "10 min", "15 min", "30 min", "1 hour"]
    
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
        
        let currentTimeOut = gameState.timeOut
        let rowID = convertTimeOutToRow(currentTimeOut)
        
        timeOutPickerView.selectRow(rowID, inComponent: 0, animated: true)
    }
    

    func convertTimeOutToRow(_ to: Int) -> Int {
        for i in 0..<TimeOutViewController.allowedTimeOuts.count {
            if to == TimeOutViewController.allowedTimeOuts[i] {
                return i
            }
        }
        return 0
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TimeOutViewController.allowedTimeOuts.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(TimeOutViewController.allowedTimeOutTitles[row])
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gameState = gameState else {
            return
        }
        
        gameState.timeOut = TimeOutViewController.allowedTimeOuts[row]
    }
}

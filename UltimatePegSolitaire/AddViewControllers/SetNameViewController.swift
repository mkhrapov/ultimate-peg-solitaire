//
//  NameAndSaveViewController.swift
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

final class SetNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Set Name"
        let backItem = UIBarButtonItem()
        backItem.title = "Name"
        navigationItem.backBarButtonItem = backItem
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        nameTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        
        // check if initX and initY have been set
        guard let initX = GlobalStateManager.shared.initX else {
            let alert = UIAlertController(title: "No Initial Position", message: "Please set initial position on the previous screen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let initY = GlobalStateManager.shared.initY else {
            let alert = UIAlertController(title: "No Initial Position", message: "Please set initial position on the previous screen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // check if name is not empty
        
        guard let boardNameRaw = nameTextField.text else {
            let alert = UIAlertController(title: "No Name", message: "Please set the board's name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let boardName = boardNameRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if boardName.count == 0 {
            let alert = UIAlertController(title: "No Name", message: "Please set the board's name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        var allowed = [Int]()
        for i in GlobalStateManager.shared.newBoard.allowed {
            if i {
                allowed.append(1)
            }
            else {
                allowed.append(0)
            }
        }
         
        GlobalStateManager.shared.newBoard = Board(
            GlobalStateManager.shared.newBoard.X,
            GlobalStateManager.shared.newBoard.Y,
            initX,
            initY,
            boardName,
            allowed
        )
        
        BoardManager.shared.addBoard(GlobalStateManager.shared.newBoard)
        
        /* TODO
         GlobalStateManager.shared.newBoard = Board(4, 4, 0, 0, "New Board", [
             1, 1, 1, 1,
             1, 1, 1, 1,
             1, 1, 1, 1,
             1, 1, 1, 1
         ])
         
         GlobalStateManager.shared.solvable = nil
         GlobalStateManager.shared.initX = nil
         GlobalStateManager.shared.initY = nil
         GlobalStateManager.shared.name = nil
         
         Do long jump
         
         
         */
    }
}

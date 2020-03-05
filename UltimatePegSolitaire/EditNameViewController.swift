//
//  EditNameViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 3/3/20.
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

final class EditNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editInitialPositionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = GlobalStateManager.shared.currentPlayingBoardName ?? "Unknown"
        navigationItem.title = "Edit " + name
        let backItem = UIBarButtonItem()
        backItem.title = "Edit Name"
        navigationItem.backBarButtonItem = backItem
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        editInitialPositionButton.layer.cornerRadius = 10
        editInitialPositionButton.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        newNameTextField.delegate = self
        newNameTextField.text = name
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        
        // check if name is not empty
        guard let boardNameRaw = newNameTextField.text else {
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
        
        let oldName = GlobalStateManager.shared.currentPlayingBoardName ?? "Unknown"
        GlobalStateManager.shared.games[boardName] = GlobalStateManager.shared.games[oldName]
        GlobalStateManager.shared.games[oldName] = nil
        
        BoardManager.shared.rename(oldName, boardName)
        BoardManager.shared.persist()
        
        self.performSegue(withIdentifier: "segueAfterRenamingBoard", sender: nil)
    }
    
    
    @IBAction func editInitialPositionButtonAction(_ sender: UIButton) {
    }
    
    
    
}

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
    
    var board: Board?
    
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Play"
        let backItem = UIBarButtonItem()
        backItem.title = "Play"
        navigationItem.backBarButtonItem = backItem
        
        newGameButton.layer.cornerRadius = 10
        newGameButton.clipsToBounds = true
        undoButton.layer.cornerRadius = 10
        undoButton.clipsToBounds = true
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func newGameAction(_ sender: UIButton) {
    }
    
    
    @IBAction func undoAction(_ sender: UIButton) {
    }
    
}

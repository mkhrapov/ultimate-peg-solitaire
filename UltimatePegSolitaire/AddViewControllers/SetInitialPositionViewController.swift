//
//  SelectInitialPositionViewController.swift
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

final class SetInitialPositionViewController: UIViewController {

    
    @IBOutlet weak var setInitialPositionView: SetInitialPositionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Set Initial Position"
        let backItem = UIBarButtonItem()
        backItem.title = "Initial Position"
        navigationItem.backBarButtonItem = backItem
        
        setInitialPositionView.board = GlobalStateManager.shared.newBoard
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let loc = touch.location(in: setInitialPositionView)
        
        if loc.x < 0 || loc.y < 0 || loc.x > setInitialPositionView.bounds.width || loc.y > setInitialPositionView.bounds.height {
            return
        }
        
        if let (x, y) = setInitialPositionView.decipher(loc.x, loc.y),
            let solvable = GlobalStateManager.shared.solvable
        {
            let X = GlobalStateManager.shared.newBoard.X
            let i = y*X + x
            
            if solvable[i] {
                var allowed = [Int]()
                for i in GlobalStateManager.shared.newBoard.allowed {
                    if i {
                        allowed.append(1)
                    }
                    else {
                        allowed.append(0)
                    }
                }
                
                GlobalStateManager.shared.initX = x
                GlobalStateManager.shared.initY = y
                GlobalStateManager.shared.newBoard = Board(
                    GlobalStateManager.shared.newBoard.X,
                    GlobalStateManager.shared.newBoard.Y,
                    x,
                    y,
                    GlobalStateManager.shared.newBoard.name,
                    allowed
                )
                setInitialPositionView.board = GlobalStateManager.shared.newBoard
                setInitialPositionView.setNeedsDisplay() 
            }
        }
    }
}

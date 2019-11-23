//
//  SelectHolesViewController.swift
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

final class RemoveHolesViewController: UIViewController {

    @IBOutlet weak var removeHolesView: RemoveHolesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Remove Holes"
        let backItem = UIBarButtonItem()
        backItem.title = "Holes"
        navigationItem.backBarButtonItem = backItem
        
        removeHolesView.board = GlobalStateManager.shared.newBoard
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let loc = touch.location(in: removeHolesView)
        
        if loc.x < 0 || loc.y < 0 || loc.x > removeHolesView.bounds.width || loc.y > removeHolesView.bounds.height {
            return
        }
        
        if let (x, y) = removeHolesView.decipher(loc.x, loc.y) {
            let X = GlobalStateManager.shared.newBoard.X
            let Y = GlobalStateManager.shared.newBoard.Y
            let name = GlobalStateManager.shared.newBoard.name
            let initX = GlobalStateManager.shared.newBoard.initX
            let initY = GlobalStateManager.shared.newBoard.initY
            
            var allowed = [Int]()
            
            for y1 in 0..<Y {
                for x1 in 0..<X {
                    let i = y1*X + x1
                    
                    if x1 == x && y1 == y {
                        let flip = GlobalStateManager.shared.newBoard.allowed[i] ? 0 : 1
                        allowed.append(flip)
                    }
                    else {
                        let same = GlobalStateManager.shared.newBoard.allowed[i] ? 1 : 0
                        allowed.append(same)
                    }
                }
            }
            
            let newBoard = Board(X, Y, initX, initY, name, allowed)
            GlobalStateManager.shared.newBoard = newBoard
            removeHolesView.board = newBoard
            removeHolesView.setNeedsDisplay()
        }
    }
}

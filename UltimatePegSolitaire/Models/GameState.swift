//
//  GameState.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/7/19.
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


import Foundation


final class GameState {
    var board: Board
    var positions: [Position]
    
    
    
    
    init?(_ name: String) {
        if let board = BoardManager.shared.getBoardByName(name) {
            self.board = board
            self.positions = [Position]()
            self.positions.append(self.board.initialPosition())
        }
        else {
            return nil
        }
    }
}

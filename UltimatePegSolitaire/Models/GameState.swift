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
    var solution: Position?
    var moveIndex = 0
    var showArrows = false
    
    var last: Position {
        if let position = positions.last {
            return position
        }
        else {
            fatalError("Positions array must always be non-emtry")
        }
    }
    
    
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
    
    
    func undo() {
        if positions.count > 1 {
            positions.remove(at: positions.endIndex - 1)
        }
    }
    
    
    func touch(_ x: Int, _ y: Int) {
        if board.isAllowed(x, y) {
            if last.selected == -1 {
                if last.isOccupied(x, y) {
                    last.select(x, y)
                }
            }
            else {
                if last.isOccupied(x, y) {
                    last.select(x, y)
                }
                else {
                    if last.isValidMoveTarget(x, y) {
                        applyMove(x, y)
                    }
                    else {
                        last.deselect()
                    }
                }
            }
        }
    }
    
    
    func applyMove(_ x: Int, _ y: Int) {
        let i = y*board.X + x
        if let move = last.validMoves[i] {
            let child = last.child(move)
            last.deselect()
            positions.append(child)
        }
    }
    
    
    func resetVisualization() {
        solution = board.initialPosition()
        moveIndex = 0
        showArrows = false
    }
    
    
    func next() {
        guard let moves = board.solution else {
            return
        }
        
        guard let solution = solution else {
            return
        }
        
        if showArrows {
            showArrows = false
            if moveIndex < moves.endIndex {
                let move = moves[moveIndex]
                
                if solution.legalMove(move) {
                    moveIndex += 1
                    solution.select(move.sourceX, move.sourceY)
                    solution.move(move.targetX, move.targetY)
                }
            }
        }
        else {
            showArrows = true
        }
    }
}

//
//  SolvablePositions.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/23/19.
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

final class SolvablePositions {
    let board: Board
    
    
    init(_ b: Board) {
        board = b
    }
    
    
    func noErrors() -> Bool {
        if !isConnected() {
            return false
        }
        
        return true
    }
    
    
    func isConnected() -> Bool {
        let graph = GraphRepresentation(board)
        return graph.isConnected()
    }
    
    
    func calculateSolvablePositions() -> [Bool] {
        var solvable = Array(repeating: false, count: board.allowed.count)
        var finalParities = [Parity]()
        
        for (i, value) in board.allowed.enumerated() {
            if value {
                let position = board.singleSurvivor(i)
                let parity = position.parity()
                finalParities.append(parity)
            }
        }
        
        for (i, value) in board.allowed.enumerated() {
            if value {
                let position = board.singleVacancy(i)
                let parity = position.parity()
                if finalParities.contains(parity) {
                    solvable[i] = true
                }
            }
        }
        
        return solvable
    }
}

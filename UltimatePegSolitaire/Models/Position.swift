//
//  Position.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 8/25/19.
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


final class Position {
    let board: Board
    var occupied: [Bool]
    var history: [Move]
    var id: String? = nil
    var compactnessScore = -1
    var selected = -1
    var validMoveTargets: [Int]
    var validMoves: [Int: Move]
    
    
    init(_ b: Board) {
        self.board = b
        occupied = [Bool](repeating: false, count: board.X*board.Y)
        for i in 0..<occupied.count {
            if board.isAllowed(i) {
                occupied[i] = true
            }
        }
        
        validMoveTargets = []
        validMoves = [Int: Move]()
        history = []
    }
    
    
    func set(_ x : Int, _ y: Int, _ state: Bool) {
        let i = y*board.X + x
        occupied[i] = state
    }
    
    
    func set(_ i: Int, _ state: Bool) {
        occupied[i] = state
    }
    
    
    func setAllEmpty() {
        for i in 0..<occupied.count {
            occupied[i] = false
        }
    }
    
    
    func isOccupied(_ x: Int, _ y: Int) -> Bool {
        let i = y*board.X + x
        return occupied[i]
    }
    
    
    func isComplement(_ other: Position) -> Bool {
        for i in 0..<occupied.count {
            if board.isAllowed(i) {
                if self.occupied[i] == other.occupied[i] {
                    return false
                }
            }
        }
        return true
    }
    
    
    func select(_ x: Int, _ y: Int) {
        let i = y*board.X + x
        selected = i
        
        validMoveTargets = []
        validMoves = [:]
        
        var moves: [Move] = []
        moves.append(Move(x, y, x+1,   y, x+2,   y))
        moves.append(Move(x, y, x-1,   y, x-2,   y))
        moves.append(Move(x, y,   x, y-1,   x, y-2))
        moves.append(Move(x, y,   x, y+1,   x, y+2))
        
        for move in moves {
            if legalMove(move) {
                let i = move.targetY * board.X + move.targetX
                validMoveTargets.append(i)
                validMoves[i] = move
            }
        }
    }
    
    
    func deselect() {
        selected = -1
        validMoveTargets = []
        validMoves = [:]
    }
    
    
    func isSelected(_ x: Int, _ y: Int) -> Bool {
        return selected == y*board.X + x
    }
    
    
    func legalMove(_ m: Move) -> Bool {
        if board.isAllowed(m.midX, m.midY) &&
            board.isAllowed(m.targetX, m.targetY) &&
            self.isOccupied(m.midX, m.midY) &&
            !self.isOccupied(m.targetX, m.targetY)
        {
            return true
        }
        return false
    }
    
    
    func isValidMoveTarget(_ x: Int, _ y: Int) -> Bool {
        let i = y*board.X + x
        return validMoveTargets.contains(i)
    }
    
    
    func someCellSelected() -> Bool {
        return selected != -1
    }
    
    
    func move(_ x: Int, _ y: Int) {
        let i = y*board.X + x
        let move = validMoves[i]!
        let j = move.midY * board.X + move.midX
        
        occupied[selected] = false
        occupied[j] = false
        occupied[i] = true
        
        deselect()
        history.append(move)
    }
    
    
    func undo() {
        guard let move = history.last else {
            return
        }
        
        let i1 = move.sourceY * board.X + move.sourceX
        let i2 = move.midY * board.X + move.midX
        let i3 = move.targetY * board.X + move.targetX
        
        occupied[i1] = true
        occupied[i2] = true
        occupied[i3] = false;
        
        history.remove(at: history.endIndex - 1)
        deselect()
    }
    
    
    func isFinal() -> Bool {
        var counter = 0
        
        for i in 0..<occupied.count {
            if board.isAllowed(i) {
                if occupied[i] {
                    counter += 1
                }
            }
        }
        
        return counter == 1
    }
    
    
    func getID() -> String {
        if id != nil {
            return id!
        }
        else {
            id = calculateID()
            return id!
        }
    }
    
    
    func calculateID() -> String {
        var ids = ""
        
        for i in 0..<occupied.count {
            if board.isAllowed(i) {
                if occupied[i] {
                    ids += "1"
                }
                else {
                    ids += "0"
                }
            }
            else {
                ids += "0"
            }
        }
        
        return ids
    }
    
    
    func getScore() -> Int {
        if compactnessScore == -1 {
            compactnessScore = calculateScore()
        }
        return compactnessScore
    }
    
    
    func calculateScore() -> Int {
        var score = 0
        
        for i in 0..<occupied.count {
            if board.isAllowed(i) && occupied[i] {
                let x = i % board.X
                let y = i / board.X
                
                if empty(x, y+1) {
                    score += 1
                }
                
                if empty(x, y-1) {
                    score += 1
                }
                
                if empty(x+1, y) {
                    score += 1
                }
                
                if empty(x-1, y) {
                    score += 1
                }
            }
        }
        
        return score
    }
    
    
    func empty(_ x: Int, _ y: Int) -> Bool {
        if x < 0 { return true }
        if x >= board.X { return true }
        if y < 0 { return true }
        if y >= board.Y {return true }
        
        let i = y*board.X + x
        
        if !board.isAllowed(i) { return true }
        if !occupied[i] { return true }
        
        return false
    }
    
    
    func child(_ move: Move) -> Position {
        let child = Position(self.board)
        
        for i in 0..<occupied.count {
            if board.isAllowed(i) {
                child.occupied[i] = self.occupied[i]
            }
        }
        
        child.history.append(contentsOf: self.history)
        child.history.append(move)
        
        child.set(move.sourceX, move.sourceY, false)
        child.set(move.midX, move.midY, false)
        child.set(move.targetX, move.targetY, true)
        
        return child
    }
    
    
    func children() -> [Position] {
        var children = [Position]()
        
        for i in 0..<occupied.count {
            if board.isAllowed(i) && occupied[i] {
                let x = i % board.X
                let y = i / board.X
                
                var moves: [Move] = []
                moves.append(Move(x, y, x+1,   y, x+2,   y))
                moves.append(Move(x, y, x-1,   y, x-2,   y))
                moves.append(Move(x, y,   x, y-1,   x, y-2))
                moves.append(Move(x, y,   x, y+1,   x, y+2))
                
                for move in moves {
                    if legalMove(move) {
                        children.append(self.child(move))
                    }
                }
            }
        }
        
        return children
    }
    
    
    func parity() -> Parity {
        var counts: [Int] = Array(repeating: 0, count: 7)
        
        for (i, value) in occupied.enumerated() {
            if value {
                counts[0] += 1
                let index123 = board.labels123[i]
                let index456 = board.labels456[i]
                counts[index123] += 1
                counts[index456] += 1
            }
        }
        
        return Parity(counts)
    }
}

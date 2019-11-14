//
//  Board.swift
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

final class Board {
    let X: Int
    let Y: Int
    let allowed: [Bool]
    
    var initX: Int
    var initY: Int
    var name: String
    var pruningNumber = 200
    var timeToSolveSeconds = 0.0
    var solution: [Move]? = nil
    var complementary = false
    
    
    init(_ x: Int, _ y: Int, _ init_x: Int, _ init_y: Int, _ name: String, _ initAllowed: [Int]) {
        X = x
        Y = y
        initX = init_x
        initY = init_y
        self.name = name
        
        var tmpAllowed: [Bool] = []
        for i in initAllowed {
            if i == 1 {
                tmpAllowed.append(true)
            }
            else {
                tmpAllowed.append(false)
            }
        }
        
        allowed = tmpAllowed
        
        if X < 1 {
            fatalError("X must be positive")
        }
        
        if Y < 1 {
            fatalError("Y must be positive")
        }
        
        if X*Y != allowed.count {
            fatalError("Mismatch between size and array size")
        }
    }
    
    func isAllowed(_ i: Int) -> Bool {
        if i < 0 || i >= allowed.count {
            return false
        }
        
        return allowed[i]
    }
    
    
    func isAllowed(_ x: Int, _ y: Int) -> Bool {
        if x < 0 || y < 0 || x >= X || y >= Y {
            return false
        }
        
        return isAllowed(y*X + x)
    }
    
    
    func initialPosition() -> Position {
        let position = Position(self)
        position.set(initX, initY, false)
        return position
    }
    
}

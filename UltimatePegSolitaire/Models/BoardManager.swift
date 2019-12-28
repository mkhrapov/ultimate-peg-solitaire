//
//  BoardFactory.swift
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

final class BoardManager {
    static let shared = BoardManager()

    private var boards = [Board]()
    
    init() {
           addInitialBoards()
    }
    
    
    func getBoardByName(_ name: String) -> Board? {
        for board in boards {
            if board.name == name {
                return board
            }
        }
        return nil
    }
    
    
    var count: Int {
        get {
            return boards.count
        }
    }
    
    
    subscript(index: Int) -> Board {
        get {
            return boards[index]
        }
        set(newValue) {
            boards[index] = newValue
        }
    }
    
    
    func addBoard(_ b: Board) {
        boards.insert(b, at: 0)
    }
    
    
    func addInitialBoards() {
        boards.append(Board(7, 7, 3, 3, "English", [
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0
        ]))
        
        boards.append(Board(7, 7, 2, 0, "French", [
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0
        ]))
        
        
        boards.append(Board(4, 6, 1, 1, "4x6", [
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
            ]))
        
        boards.append(Board(6, 6, 1, 1, "6x6", [
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1
            ]))
        
        boards.append(Board(8, 8, 2, 1, "8x8", [
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1
             ]))
         
        
         
         boards.append(Board(9, 9, 4, 4, "9x9", [
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1, 1, 1
             ]))
        
        
        boards.append(Board(5, 7, 2, 3, "Cross 1", [
             0, 1, 1, 1, 0,
             0, 1, 1, 1, 0,
             1, 1, 1, 1, 1,
             1, 1, 1, 1, 1,
             1, 1, 1, 1, 1,
             0, 1, 1, 1, 0,
             0, 1, 1, 1, 0
             ]))
         
        
         
         boards.append(Board(7, 9, 3, 0, "Cross 2", [
             0, 0, 1, 1, 1, 0, 0,
             0, 0, 1, 1, 1, 0, 0,
             0, 0, 1, 1, 1, 0, 0,
             1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1, 1,
             0, 0, 1, 1, 1, 0, 0,
             0, 0, 1, 1, 1, 0, 0,
             0, 0, 1, 1, 1, 0, 0
             ]))
         
         
         
         boards.append(Board(6, 6, 2, 3, "Cross 3", [
             0, 1, 1, 1, 0, 0,
             0, 1, 1, 1, 0, 0,
             1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1,
             1, 1, 1, 1, 1, 1,
             0, 1, 1, 1, 0, 0
             ]))
        
        
        boards.append(Board(8, 8, 3, 4, "Cross 4", [
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0
            ]))
        
        
        
        boards.append(Board(7, 8, 3, 3, "Diamond 32", [
            0, 0, 0, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 0, 0, 0
            ]))
        
        
        
        boards.append(Board(9, 9, 3, 1, "Diamond 41", [
            0, 0, 0, 0, 1, 0, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0
            ]))
        
        
        boards.append(Board(7, 9, 3, 4, "Hermary 39", [
            0, 0, 0, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 0, 0, 0
            ]))
        
        
        
        boards.append(Board(9, 9, 4, 4, "Huber 37", [
            0, 0, 0, 0, 1, 0, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0
            ]))
        
        
        
        
        boards.append(Board(9, 7, 1, 1, "Kralenspel", [
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0
            ]))
        
        boards.append(Board(9, 9, 4, 0, "Siege 67", [
                    0, 1, 1, 1, 1, 1, 1, 1, 0,
                    0, 0, 1, 1, 1, 1, 1, 0, 0,
                    1, 1, 1, 1, 1, 1, 1, 1, 1,
                    1, 1, 1, 1, 1, 1, 1, 1, 1,
                    1, 1, 1, 1, 1, 1, 1, 1, 1,
                    1, 1, 1, 1, 1, 1, 1, 1, 1,
                    1, 1, 1, 1, 1, 1, 1, 1, 1,
                    0, 0, 1, 1, 1, 1, 1, 0, 0,
                    0, 0, 1, 1, 1, 1, 1, 0, 0
                ]))
        
            
            boards.append(Board(9, 9, 4, 4, "Wiegleb", [
                0, 0, 0, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 0, 0, 0,
                1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 0, 0, 0
                ]))
        
    }
    
   
}

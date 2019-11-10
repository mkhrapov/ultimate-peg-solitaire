//
//  GlobalStateManager.swift
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


import Foundation


final class GlobalStateManager {
    static var shared = GlobalStateManager()
    
    var currentPlayingBoardName: String?
    var games: [String:GameState]
    
    
    init() {
        games = [String:GameState]()
    }
    
    
    func getGameByName(_ name: String) -> GameState? {
        if let gameState = games[name] {
            return gameState
        }
        else {
            let gameState = GameState(name)
            games[name] = gameState
            return gameState
        }
    }
    
    
    func getCurrentPlayingBoard() -> GameState? {
        guard let name = currentPlayingBoardName else {
            return nil
        }
        
        return getGameByName(name)
    }
    
    
    func replaceCurrentPlayingBoard() -> GameState? {
        guard let name = currentPlayingBoardName else {
            return nil
        }
        
        let gameState = GameState(name)
        games[name] = gameState
        return gameState
    }
    
    
    
}

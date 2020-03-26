//
//  IconManager.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 3/25/20.
//  Copyright © 2020 Maksim Khrapov. All rights reserved.
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
import UIKit


final class IconManager {
    static var shared = IconManager()


    var boardImagesLight: [String:UIImage]
    var boardImagesDark: [String:UIImage]
    
    
    init() {
        boardImagesLight = [String:UIImage]()
        boardImagesDark = [String:UIImage]()
    }
    
    
    func delete(_ name: String) {
        boardImagesLight[name] = nil
        boardImagesDark[name] = nil
    }
    
    
    func rename(_ oldName: String, _ newName: String) {
        boardImagesLight[newName] = boardImagesLight[oldName]
        boardImagesDark[newName] = boardImagesDark[oldName]
        
        boardImagesLight[oldName] = nil
        boardImagesDark[oldName] = nil
    }
    

    func getImageByName(_ name: String) -> UIImage {
        guard let board = BoardManager.shared.getBoardByName(name) else {
            return UIImage()
        }
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return cachedDarkImage(board)
            }
            else { // Light
                return cachedLightImage(board)
            }
        }
        else { // Also Light
            return cachedLightImage(board)
        }
    }
    
    
    func cachedDarkImage(_ board: Board) -> UIImage {
        if let img = boardImagesDark[board.name] {
            return img
        }
        else {
            let img = makeImage(board)
            boardImagesDark[board.name] = img
            return img
        }
    }
    
    
    func cachedLightImage(_ board: Board) -> UIImage {
        if let img = boardImagesLight[board.name] {
            return img
        }
        else {
            let img = makeImage(board)
            boardImagesLight[board.name] = img
            return img
        }
    }
    
    
    func makeImage(_ board: Board) -> UIImage {
        let size = CGSize(width: 200, height: 200)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { ctx in
            let bi = BoardIcon(board: board, size: size, context: ctx)
            bi.draw()
        }
    }
}

//
//  PruningSearch.swift
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


final class PruningSearch {
    let initialPosition: Position
    var pruningNumber = 200
    var solutions = [Position]()
    
    
    init(_ initialPosition: Position) {
        self.initialPosition = initialPosition
    }
    
    
    func prune(_ newPruningNumber: Int) {
        pruningNumber = newPruningNumber
    }
    
    
    func getSolution(_ i: Int) -> Position {
        return solutions[i]
    }
    
    
    func search() -> Int {
        var gen0 = [Position]()
        gen0.append(initialPosition)
        searchByGeneration(gen0)
        return solutions.count
    }
    
    func searchByGeneration(_ currentGen: [Position]) {
        if currentGen.count == 0 {
            return
        }
        
        var dedup = Set<String>()
        var children = [Position]()
        
        for p in currentGen {
            for child in p.children() {
                if !dedup.contains(child.getID()) {
                    dedup.insert(child.getID())
                    children.append(child)
                }
            }
        }
        
        if children.count == 0 {
            return
        }
        
        for p in children {
            if p.isFinal() {
                solutions.append(p)
            }
        }
        
        if solutions.count > 0 {
            return
        }
        
        if pruningNumber > 0 && children.count > pruningNumber {
            var children2 = children.sorted(by: { $0.getScore() < $1.getScore() } )
            var children3 = [Position]()
            for i in 0..<pruningNumber {
                children3.append(children2[i])
            }
            searchByGeneration(children3)
        }
        else {
            searchByGeneration(children)
        }
    }
}

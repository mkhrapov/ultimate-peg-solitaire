//
//  GraphRepresentation.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 1/6/20.
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


final class GraphRepresentation {
    var graph: [Int:[Int]]
    var dfsVisited: [Int:Bool]
    var emptyBoard = true
    
    init(_ board: Board) {
        graph = [Int:[Int]]()
        dfsVisited = [Int:Bool]()
        
        for id in 0..<board.allowed.count {
            if board.allowed[id] {
                emptyBoard = false
                var edges = [Int]()
                
                for n in board.neighbors(id) {
                    if board.allowed[n] {
                        edges.append(n)
                    }
                }
                
                graph[id] = edges
            }
        }
        
    }
    
    
    func isConnected() -> Bool {
        if emptyBoard {
            return false
        }
        
        if anyUnconnectedNode() {
            return false
        }
        
        dfsVisited.removeAll()
        var runFrom = 0
        
        for i in graph.keys {
            dfsVisited[i] = false
            runFrom = i
        }
        
        depthFirstSearch(startWithNode: runFrom)
        
        for i in dfsVisited.keys {
            if dfsVisited[i] == false {
                return false
            }
        }
        
        return true
    }
    
    
    func anyUnconnectedNode() -> Bool {
        for e in graph.values {
            if e.count == 0 {
                return true
            }
        }
        return false
    }
    
    
    func depthFirstSearch(startWithNode i: Int) {
        dfsVisited[i] = true
        
        for n in graph[i]! {
            if dfsVisited[n] == false {
                depthFirstSearch(startWithNode: n)
            }
        }
    }
}

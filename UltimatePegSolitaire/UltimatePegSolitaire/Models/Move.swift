//
//  Move.swift
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

struct Move {
    let sourceX: Int
    let sourceY: Int
    let midX: Int
    let midY: Int
    let targetX: Int
    let targetY: Int
    
    init(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, _ x3: Int, _ y3: Int) {
        sourceX = x1
        sourceY = y1
        
        midX = x2
        midY = y2
        
        targetX = x3
        targetY = y3
    }
}

//
//  Parity.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 1/11/20.
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


struct Parity: Equatable {
    let t1: Bool
    let t2: Bool
    let t3: Bool
    let t4: Bool
    let t5: Bool
    let t6: Bool
    
    init(_ arr: [Int]) {
        if arr.count != 7 {
            fatalError("Array initializer must contain 7 elements.")
        }
        
        t1 = (arr[0] - arr[1]) % 2 == 0
        t2 = (arr[0] - arr[2]) % 2 == 0
        t3 = (arr[0] - arr[3]) % 2 == 0
        t4 = (arr[0] - arr[4]) % 2 == 0
        t5 = (arr[0] - arr[5]) % 2 == 0
        t6 = (arr[0] - arr[6]) % 2 == 0
    }
}

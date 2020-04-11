//
//  PruningNumber.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 4/11/20.
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

final class PruningNumber {
    static let shared = PruningNumber()
    
    let allowedPruningNumbers = [100, 200, 300, 400, 500, 750, 1000]
    
    func row(_ n: Int) -> Int {
        for i in 0..<allowedPruningNumbers.count {
            if allowedPruningNumbers[i] == n {
                return i
            }
        }
        return 0
    }
}

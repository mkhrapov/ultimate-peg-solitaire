//
//  MyColors.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/4/19.
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
import UIKit



final class MyColors {
    
    lazy var holeColor = makeColor(0, 255, 0)
    
    var background: CGColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground.cgColor
        }
        else {
            return UIColor.white.cgColor
        }
    }
    
    var border: CGColor {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor.gray.cgColor
            }
            else {
                return UIColor.black.cgColor
            }
        }
        else {
            return UIColor.black.cgColor
        }
    }
    
    init() {
        
    }
    
    
    func makeColor(_ red: Int, _ green: Int, _ blue: Int) -> CGColor {
        let scale:CGFloat = 255.0
        
        return UIColor(
            red: CGFloat(red)/scale,
            green: CGFloat(green)/scale,
            blue: CGFloat(blue)/scale,
            alpha: 1.0
            ).cgColor
    }
}

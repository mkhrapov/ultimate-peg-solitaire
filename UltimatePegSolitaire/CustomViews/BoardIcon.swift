//
//  BoardIcon.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 1/12/20.
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

final class BoardIcon {
    let board: Board
    let size: CGSize
    let context: UIGraphicsImageRendererContext
    
    let position: Position
    let myColors: MyColors
    var offsetX: CGFloat = 50.0
    var offsetY: CGFloat = 50.0
    var cellSize: CGFloat = 0.0
    let X: Int
    let Y: Int
    
    
    init(board b: Board, size s: CGSize, context c: UIGraphicsImageRendererContext) {
        board = b
        size = s
        context = c
        
        position = board.initialPosition()
        myColors = MyColors()
        X = board.X
        Y = board.Y
    }
    
    
    func draw() {
        calcParams()
        fillBackground()
        drawCells()
    }
    
    
    func calcParams() {
        let width = size.width - CGFloat(100.0)
        let height = size.height - CGFloat(100.0)
        
        if X > Y {
            cellSize = width / CGFloat(X)
            offsetY = (height - cellSize*CGFloat(Y))/2.0 + CGFloat(50.0)
        }
        else if Y > X {
            cellSize = height / CGFloat(Y)
            offsetX = (width - cellSize*CGFloat(X))/2.0 + CGFloat(50.0)
        }
        else {
            cellSize = width / CGFloat(X)
        }
    }
    
    
    func fillBackground() {
        UIColor(cgColor: myColors.background).setFill()
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context.fill(rect)
    }
    
    
    func drawCells() {
        for x in 0..<X {
            for y in 0..<Y {
                if board.isAllowed(x, y) {
                    let cell = makeCell(x, y)
                    drawBorder(cell)
                    if position.isOccupied(x, y) {
                        drawPeg(cell: cell, color: myColors.normal)
                    }
                }
            }
        }
    }
    
    
    func makeCell(_ x: Int, _ y: Int) -> CGRect {
        let dx = offsetX + cellSize*CGFloat(x)
        let dy = offsetY + cellSize*CGFloat(y)
        return CGRect(x: dx, y: dy, width: cellSize, height: cellSize)
    }
    
    
    func drawBorder(_ cell: CGRect) {
        UIColor(cgColor: myColors.border).setStroke()
        context.cgContext.setLineWidth(1.0)
        context.stroke(cell)
    }
    
    
    func drawPeg(cell: CGRect, color: CGColor) {
        let smallCell = cell.insetBy(dx: 2.0, dy: 2.0)
        UIColor(cgColor: color).setFill()
        context.cgContext.fillEllipse(in: smallCell)
    }
}

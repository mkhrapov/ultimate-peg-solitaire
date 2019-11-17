//
//  VisualizeBoardView.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/16/19.
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


import UIKit

class VisualizeBoardView: UIView {
    var gameState: GameState?

    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        guard let gameState = gameState else {
            return
        }
        
        let draw = Draw(context, bounds, gameState)
        draw.draw()
    }
    
    
    func decipher(_ px: CGFloat, _ py: CGFloat) -> (Int, Int)? {
        guard let gameState = gameState else {
            return nil
        }
        
        let calc = Calc(bounds, gameState)
        return calc.decipher(px, py)
    }
    
    
    final class Calc {
        let rect: CGRect
        let gameState: GameState
        var offsetX: CGFloat = 1.0
        var offsetY: CGFloat = 1.0
        var cellSize: CGFloat = 0.0
        let X: Int
        let Y: Int
        
        
        init(_ r: CGRect, _ gs: GameState) {
            rect = r
            gameState = gs
            X = gameState.board.X
            Y = gameState.board.Y
        }
        
        
        func calcParams() {
            let width = rect.width - CGFloat(2.0)
            let height = rect.height - CGFloat(2.0)
            
            if X > Y {
                cellSize = width / CGFloat(X)
                offsetY = (height - cellSize*CGFloat(Y))/2.0 + CGFloat(1.0)
            }
            else if Y > X {
                cellSize = height / CGFloat(Y)
                offsetX = (width - cellSize*CGFloat(X))/2.0 + CGFloat(1.0)
            }
            else {
                cellSize = width / CGFloat(X)
            }
        }
        
        
        func decipher(_ px: CGFloat, _ py: CGFloat) -> (Int, Int)? {
            calcParams()
            
            let x = Int(floor((px - offsetX)/cellSize))
            let y = Int(floor((py - offsetY)/cellSize))
            
            if x < 0 || y < 0 || x >= X || y >= Y {
                return nil
            }
            
            return (x, y)
        }
    }
    
    
    final class Draw {
        let context: CGContext
        let rect: CGRect
        let gameState: GameState
        let myColors: MyColors
        var offsetX: CGFloat = 1.0
        var offsetY: CGFloat = 1.0
        var cellSize: CGFloat = 0.0
        let X: Int
        let Y: Int
        var position: Position
        
        
        init(_ c: CGContext, _ r: CGRect, _ gs: GameState) {
            context = c
            rect = r
            gameState = gs
            myColors = MyColors()
            X = gameState.board.X
            Y = gameState.board.Y
            
            if let p = gs.solution {
                position = p
            }
            else {
                position = gs.board.initialPosition()
            }
        }
        
        
        func draw() {
            calcParams()
            fillBackground()
            drawCells()
            if gameState.showArrows {
                if let moves = gameState.board.solution {
                    if gameState.moveIndex < moves.endIndex {
                        let move = moves[gameState.moveIndex]
                        drawArrow(move)
                    }
                }
            }
        }
        
        
        func calcParams() {
            let width = rect.width - CGFloat(2.0)
            let height = rect.height - CGFloat(2.0)
            
            if X > Y {
                cellSize = width / CGFloat(X)
                offsetY = (height - cellSize*CGFloat(Y))/2.0 + CGFloat(1.0)
            }
            else if Y > X {
                cellSize = height / CGFloat(Y)
                offsetX = (width - cellSize*CGFloat(X))/2.0 + CGFloat(1.0)
            }
            else {
                cellSize = width / CGFloat(X)
            }
        }
        
        
        func fillBackground() {
            context.setFillColor(myColors.background)
            context.fill(rect)
        }
        
        
        func drawCells() {
            for x in 0..<X {
                for y in 0..<Y {
                    let i = y*X + x
                    if gameState.board.isAllowed(x, y) {
                        let cell = makeCell(x, y)
                        drawBorder(cell)
                        if position.isOccupied(x, y) {
                            if position.selected == i {
                                drawPeg(cell: cell, color: myColors.selected)
                            }
                            else {
                                drawPeg(cell: cell, color: myColors.normal)
                            }
                        }
                        else if position.isValidMoveTarget(x, y) {
                            drawPeg(cell: cell, color: myColors.allowed)
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
            context.setStrokeColor(myColors.border)
            context.setLineWidth(1)
            context.beginPath()
            context.addRect(cell)
            context.strokePath()
        }
        
        
        func drawPeg(cell: CGRect, color: CGColor) {
            let smallCell = shrinkCell(cell)
            
            context.setFillColor(color)
            context.fillEllipse(in: smallCell)
        }
        
        
        func shrinkCell(_ cell: CGRect) -> CGRect {
            return CGRect(
                x: cell.minX + CGFloat(2.0),
                y: cell.minY + CGFloat(2.0),
                width: cell.width - CGFloat(4.0),
                height: cell.height - CGFloat(4.0)
            )
        }
        
        
        func drawArrow(_ move: Move) {
            let x1 = offsetX + cellSize*(CGFloat(move.sourceX) + 0.5)
            let y1 = offsetY + cellSize*(CGFloat(move.sourceY) + 0.5)
            
            let x2 = offsetX + cellSize*(CGFloat(move.targetX) + 0.5)
            let y2 = offsetY + cellSize*(CGFloat(move.targetY) + 0.5)
            
            context.setStrokeColor(myColors.border)
            context.setLineWidth(4)
            
            context.beginPath()
            
            context.move(to: CGPoint(x: x1, y: y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            
            context.strokePath()
            
            // draw Arrow's Head
            if move.sourceY == move.targetY {
                // horizontal arrow
                if move.sourceX < move.targetX {
                    arrowPointsRight(move.targetX, move.targetY)
                }
                else {
                    arrowPointsLeft(move.targetX, move.targetY)
                }
            }
            else if move.sourceX == move.targetX {
                // vertical arrows; larger Y go down
                if move.sourceY < move.targetY {
                    arrowPointsDown(move.targetX, move.targetY)
                }
                else {
                    arrowPointsUp(move.targetX, move.targetY)
                }
            }
            
        }
        
        
        func arrowPointsRight(_ x: Int, _ y: Int) {
            arrowNorthWest(x, y)
            arrowSouthWest(x, y)
        }
        
        
        func arrowPointsLeft(_ x: Int, _ y: Int) {
            arrowNorthEast(x, y)
            arrowSouthEast(x, y)
        }
        
        
        func arrowPointsUp(_ x: Int, _ y: Int) {
            arrowSouthWest(x, y)
            arrowSouthEast(x, y)
        }
        
        
        func arrowPointsDown(_ x: Int, _ y: Int) {
            arrowNorthWest(x, y)
            arrowNorthEast(x, y)
        }
        
        
        func arrowNorthWest(_ x: Int, _ y: Int) {
            let x1 = offsetX + cellSize*(CGFloat(x) + 0.5)
            let y1 = offsetY + cellSize*(CGFloat(y) + 0.5)
            
            let x2 = x1 - 10.0
            let y2 = y1 - 10.0
            
            context.beginPath()
            
            context.move(to: CGPoint(x: x1, y: y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            
            context.strokePath()
        }
        
        
        func arrowNorthEast(_ x: Int, _ y: Int) {
            let x1 = offsetX + cellSize*(CGFloat(x) + 0.5)
            let y1 = offsetY + cellSize*(CGFloat(y) + 0.5)
            
            let x2 = x1 + 10.0
            let y2 = y1 - 10.0
            
            context.beginPath()
            
            context.move(to: CGPoint(x: x1, y: y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            
            context.strokePath()
        }
        
        
        func arrowSouthWest(_ x: Int, _ y: Int) {
            let x1 = offsetX + cellSize*(CGFloat(x) + 0.5)
            let y1 = offsetY + cellSize*(CGFloat(y) + 0.5)
            
            let x2 = x1 - 10.0
            let y2 = y1 + 10.0
            
            context.beginPath()
            
            context.move(to: CGPoint(x: x1, y: y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            
            context.strokePath()
        }
        
        
        func arrowSouthEast(_ x: Int, _ y: Int) {
            let x1 = offsetX + cellSize*(CGFloat(x) + 0.5)
            let y1 = offsetY + cellSize*(CGFloat(y) + 0.5)
            
            let x2 = x1 + 10.0
            let y2 = y1 + 10.0
            
            context.beginPath()
            
            context.move(to: CGPoint(x: x1, y: y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            
            context.strokePath()
        }
    }
}

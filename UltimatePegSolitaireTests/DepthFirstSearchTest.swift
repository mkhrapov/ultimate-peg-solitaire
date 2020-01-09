//
//  DepthFirstSearchTest.swift
//  UltimatePegSolitaireTests
//
//  Created by Maksim Khrapov on 1/8/20.
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


import XCTest

class DepthFirstSearchTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyBoard() {
        let b = Board(7, 7, 3, 3, "English", [
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0
        ])
        
        let graph = GraphRepresentation(b)
        XCTAssert(!graph.isConnected())
    }
    
    
    func testConnectedBoard() {
        let b = Board(7, 7, 3, 3, "English", [
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0
        ])
        
        let graph = GraphRepresentation(b)
        XCTAssert(graph.isConnected())
    }
    
    func testDisjointBoard() {
        let b = Board(7, 7, 3, 3, "English", [
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1,
            1, 1, 1, 0, 1, 1, 1
        ])
        
        let graph = GraphRepresentation(b)
        XCTAssert(!graph.isConnected())
    }
    
    
    func testFullyDisconnectedNode() {
        let b = Board(7, 7, 3, 3, "English", [
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 0, 1
        ])
        
        let graph = GraphRepresentation(b)
        XCTAssert(!graph.isConnected())
    }
    
    func testNodeOnlyConnectedByTheAngle() {
        let b = Board(7, 7, 3, 3, "English", [
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 0, 1
        ])
        
        let graph = GraphRepresentation(b)
        XCTAssert(!graph.isConnected())
    }
}

//
//  UltimatePegSolitaireTests.swift
//  UltimatePegSolitaireTests
//
//  Created by Maksim Khrapov on 5/11/19.
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


import XCTest
@testable import UltimatePegSolitaire

class UltimatePegSolitaireTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        
    func testEnglishBoard() {
        let b = Board(7, 7, 3, 3, "English", [
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(121)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions == 2)
        
        var foundComplement = false
        
        for i in 0..<numSolutions {
            let p1 = pruningSearch.getSolution(i)
            if p1.isComplement(p) {
                foundComplement = true
            }
        }
        
        XCTAssert(foundComplement)
    }
        
        
    func testFrenchBoard() {
        let b = Board(7, 7, 2, 0, "French", [
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
        
    }
    
    
    func test4x6Board() {
        let b = Board(4, 6, 1, 1, "4x6", [
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        
        
    func test6x6Board() {
        
        let b = Board(6, 6, 1, 1, "6x6", [
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func test8x8Board() {
        
        let b = Board(8, 8, 2, 1, "8x8", [
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        
        
    func test9x9Board() {
        
        let b = Board(9, 9, 4, 4, "9x9", [
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testCross1Board() {
        
        let b = Board(5, 7, 2, 3, "Cross 1", [
            0, 1, 1, 1, 0,
            0, 1, 1, 1, 0,
            1, 1, 1, 1, 1,
            1, 1, 1, 1, 1,
            1, 1, 1, 1, 1,
            0, 1, 1, 1, 0,
            0, 1, 1, 1, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        
        
    func testCross2Board() {
        
        let b = Board(7, 9, 3, 0, "Cross 2", [
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testCross3Board() {
        
        let b = Board(6, 6, 2, 3, "Cross 3", [
            0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        
        
    func testCross4Board() {
        
        
        let b = Board(8, 8, 3, 4, "Cross 4", [
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testDiamond32Board() {
        
        let b = Board(7, 8, 3, 3, "Diamond 32", [
            0, 0, 0, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(100)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        
        
    func testDiamond41Board() {
        
        let b = Board(9, 9, 3, 1, "Diamond 41", [
            0, 0, 0, 0, 1, 0, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(100)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testHermary39Board() {
        
        
        let b = Board(7, 9, 3, 4, "Hermary 39", [
            0, 0, 0, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
        
    func testHuber37Board() {
        
        let b = Board(7, 9, 3, 4, "Huber 37", [
            0, 0, 0, 1, 0, 0, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testKralenspelBoard() {
        
        
        let b = Board(9, 7, 1, 1, "Kralenspel", [
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
        

    func testSiege67Board() {

        let b = Board(9, 9, 4, 0, "Siege 67", [
            0, 1, 1, 1, 1, 1, 1, 1, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 1, 1, 0, 0,
            0, 0, 1, 1, 1, 1, 1, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(300)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testWieglebBoard() {

        let b = Board(9, 9, 4, 4, "Wiegleb", [
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0,
            0, 0, 0, 1, 1, 1, 0, 0, 0
        ])
        
        let p = b.initialPosition()
        let pruningSearch = PruningSearch(p)
        pruningSearch.prune(200)
        let numSolutions = pruningSearch.search()
        XCTAssert(numSolutions > 0)
    }
    
    
    func testTest() {
        print("Hello, Git!");
    }
}

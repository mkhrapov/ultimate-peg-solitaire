//
//  UltimatePegSolitaireUITests.swift
//  UltimatePegSolitaireUITests
//
//  Created by Maksim Khrapov on 5/11/19.
//  Copyright © 2019 Maksim Khrapov. All rights reserved.
//

import XCTest

class UltimatePegSolitaireUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicSolverFlow() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["English"]/*[[".cells.staticTexts[\"English\"]",".staticTexts[\"English\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.tap()
        element.tap()
        element.tap()
        
        let undoStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["<< Undo"]/*[[".buttons[\"<< Undo\"].staticTexts[\"<< Undo\"]",".staticTexts[\"<< Undo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        undoStaticText.tap()
        undoStaticText.tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.staticTexts["New Game"]/*[[".buttons[\"New Game\"].staticTexts[\"New Game\"]",".staticTexts[\"New Game\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let englishNavigationBar = app.navigationBars["English"]
        englishNavigationBar.buttons["Solve"].tap()
        app.buttons["Solve"].staticTexts["Solve"].tap()
        //wait until board is solved
        sleep(10)
        
        let solveNavigationBar = app.navigationBars["Solve"]
        solveNavigationBar.buttons["Visualize"].tap()
        
        let nextStaticText = app2/*@START_MENU_TOKEN@*/.staticTexts["Next >>"]/*[[".buttons[\"Next >>\"].staticTexts[\"Next >>\"]",".staticTexts[\"Next >>\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nextStaticText.tap()
        nextStaticText.tap()
        nextStaticText.tap()
        nextStaticText.tap()
        nextStaticText.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Start"]/*[[".buttons[\"Start\"].staticTexts[\"Start\"]",".staticTexts[\"Start\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Visualize"].buttons["Solve"].tap()
        solveNavigationBar.buttons["English"].tap()
        englishNavigationBar.buttons["Boards"].tap()
        
    }

}

//
//  SwatchesiOSScreenshotsUITests.swift
//  SwatchesiOSScreenshotsUITests
//
//  Created by Timothy Sanders on 2020-02-03.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import XCTest

class SwatchesiOSScreenshotsUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTakeScreenshots() {
        let app = XCUIApplication()

        // Take a shot of the SwiftUI grid.
        snapshot("01SwiftUI")
        
        // Turn on dark mode and take another shot.
        app.switches["Dark Mode"].tap()
        snapshot("02Dark Mode")
        // Don't forget to turn dark mode back off.
        app.switches["Dark Mode"].tap()

        // Take a screenshot of the adaptable grid.
        app.buttons["Adaptable"].tap()
        snapshot("03Adaptable")
        
        // Take a screenshot of the text grid.
        app.buttons["Text"].tap()
        // The whole quick brown fox text is too long for screenshot purposes, replace the text with something shorter.
        let field = app.textFields["Sample Text:"]
        field.tap() // Put focus in the field.
        field.replaceText(newString: "Dev Swatches")
        // Now dismiss the keyboard … 🙄
        app.buttons["Return"].tap()
        snapshot("04Text")
        
        // Take a screenshot of the fixed grid.
        app.buttons["Fixed"].tap()
        snapshot("05Fixed")

        // Take a screenshot of the about screen.
        app.buttons["About"].tap()
        snapshot("06About")
    }
}

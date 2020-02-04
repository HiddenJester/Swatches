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
        let darkModeSwitch = app.switches["Dark Mode"]
        darkModeSwitch.tap()
        snapshot("02Dark Mode")
        
        darkModeSwitch.tap()
        snapshot("01SwiftUI")
        
        let adaptableButton = app/*@START_MENU_TOKEN@*/.buttons["Adaptable"]/*[[".segmentedControls.buttons[\"Adaptable\"]",".buttons[\"Adaptable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        adaptableButton.tap()
        snapshot("03Adaptable")
        
        let textButton = app/*@START_MENU_TOKEN@*/.buttons["Text"]/*[[".segmentedControls.buttons[\"Text\"]",".buttons[\"Text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        textButton.tap()
        let sampleTextTextField = app.textFields["Sample Text:"]
        sampleTextTextField.tap()
        // Trying to make the text field remove text is way too complicated. So do the stupid thing: hit delete a bunch.
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        for _ in 0 ..< "The quick brown fox jumps over the lazy dog.".count {
            deleteKey.tap()
        }
        sampleTextTextField.typeText("Custom Text")

        // Now dismiss the keyboard … 🙄
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        snapshot("04Text")
        
        app/*@START_MENU_TOKEN@*/.buttons["Fixed"]/*[[".segmentedControls.buttons[\"Fixed\"]",".buttons[\"Fixed\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("05Fixed")
        
        app.buttons["About"].tap()
        snapshot("06About")
    }
}

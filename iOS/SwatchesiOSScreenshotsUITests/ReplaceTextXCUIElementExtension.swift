//
//  ReplaceTextXCUIElementExtension.swift
//  SwatchesiOSScreenshotsUITests
//
//  Created by Timothy Sanders on 2020-02-04.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import XCTest

extension XCUIElement {
    /// Replaces any existing text in the field with the new value.
    /// - Parameter newString: The new text to type into the field.
    func replaceText(newString: String) {
        // Get the current value of the field and then generate a string of deletes to clear it.
        guard let currentString = self.value as? String else {
            XCTFail("Can't get the current value of the text field")
            return
        }

        // Only do this nonsense if the value is not the placeholder text.
        if currentString != self.placeholderValue {
            tap() // Might select a word.
            tap() // Second tap clears any selection and brings up the menu.
            let selectAll = XCUIApplication().menuItems["Select All"]
            //For empty fields there will be no "Select All", so we need to check
            if selectAll.waitForExistence(timeout: 0.5), selectAll.exists {
                selectAll.tap()
            }

            let deleteChar = Character(XCUIKeyboardKey.delete.rawValue)
            let deleteString = String(currentString.map { _ in deleteChar })
            self.typeText(deleteString)
        }

        // self.value should now be the placeholder.
        XCTAssertEqual((self.value as! String).count, self.placeholderValue?.count ?? 0)
        
        self.typeText(newString)
        
        XCTAssertEqual((self.value as! String).count, newString.count)
    }
}


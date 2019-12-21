//
//  FixedColorModels.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-21.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

extension ColorModel {
    /// All of the "fixed" colurs provided by UIKit. These do not update when the color scheme is changed from light to dark. Note that these models rely
    /// on the mapping from `UIColor` to `Color`provided by Color+UIColor.swift
    /// - Returns: An array of `ColorModel` that represents all of the fixed colors.
    static func fixedColors() -> [ColorModel] {
        [
            ColorModel(color: .fixedBlack, name: "Black", supportedOS: .all),
            ColorModel(color: .fixedDarkGray, name: "Dark Gray", supportedOS: .all),
            ColorModel(color: .fixedLightGray, name: "Light Gray", supportedOS: .all),
            ColorModel(color: .fixedWhite, name: "White", supportedOS: .all),
            ColorModel(color: .fixedGray, name: "Gray", supportedOS: .all),
            ColorModel(color: .fixedRed, name: "Red", supportedOS: .all),
            ColorModel(color: .fixedGreen, name: "Green", supportedOS: .all),
            ColorModel(color: .fixedBlue, name: "Blue", supportedOS: .all),
            ColorModel(color: .fixedCyan, name: "Cyan", supportedOS: .all),
            ColorModel(color: .fixedYellow, name: "Yellow", supportedOS: .all),
            ColorModel(color: .fixedMagenta, name: "Magenta", supportedOS: .all),
            ColorModel(color: .fixedOrange, name: "Orange", supportedOS: .all),
            ColorModel(color: .fixedPurple, name: "Purple", supportedOS: .all),
            ColorModel(color: .fixedBrown, name: "Brown", supportedOS: .all),
            ColorModel(color: .fixedClear, name: "Clear", supportedOS: .all),
        ]
    }

}

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
            ColorModel(color: .fixedBlack, name: "Black"),
            ColorModel(color: .fixedDarkGray, name: "Dark Gray"),
            ColorModel(color: .fixedLightGray, name: "Light Gray"),
            ColorModel(color: .fixedWhite, name: "White"),
            ColorModel(color: .fixedGray, name: "Gray"),
            ColorModel(color: .fixedRed, name: "Red"),
            ColorModel(color: .fixedGreen, name: "Green"),
            ColorModel(color: .fixedBlue, name: "Blue"),
            ColorModel(color: .fixedCyan, name: "Cyan"),
            ColorModel(color: .fixedYellow, name: "Yellow"),
            ColorModel(color: .fixedMagenta, name: "Magenta"),
            ColorModel(color: .fixedOrange, name: "Orange"),
            ColorModel(color: .fixedPurple, name: "Purple"),
            ColorModel(color: .fixedBrown, name: "Brown"),
            ColorModel(color: .fixedClear, name: "Clear"),
        ]
    }

}

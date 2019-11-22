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

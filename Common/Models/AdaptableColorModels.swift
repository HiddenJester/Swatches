//
//  SemanticColorModels.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-14.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

extension ColorModel {
    /// The "adaptable" colors provided by UIKit. These all change when the color scheme is changed from light to dark. Note that these models rely
    /// on the mapping from `UIColor` to `Color`provided by Color+UIColor.swift. Also note that these are just the "pure" colors. The text colors like
    /// `.label` and so on are placed in `textModels()` so they can be rendered in text swatches, not color ones.
    /// - Returns: An array of `ColorModel` that represents all of the adaptable colors.
    static func adaptableColors() -> [ColorModel] {
        #if os(tvOS) // tvOS only supports a subset of the adaptable colors.
        return [
            ColorModel(color: .systemRed, name: "Sys.Red"),
            ColorModel(color: .systemGreen, name: "Sys.Green"),
            ColorModel(color: .systemBlue, name: "Sys.Blue"),
            ColorModel(color: .systemOrange, name: "Sys.Orange"),
            ColorModel(color: .systemYellow, name: "Sys.Yellow"),
            ColorModel(color: .systemPink, name: "Sys.Pink"),
            ColorModel(color: .systemPurple, name: "Sys.Purple"),
            ColorModel(color: .systemTeal, name: "Sys.Teal"),
            ColorModel(color: .systemIndigo, name: "Sys.Indigo"),
            
            ColorModel(color: .systemGray, name: "Sys.Gray"),
            
            // Separators
            ColorModel(color: .separator, name: "Separator"),
            ColorModel(color: .opaqueSeparator, name: "Opaque Sep."),
        ]
        #else
        return [
            ColorModel(color: .systemRed, name: "Sys.Red"),
            ColorModel(color: .systemGreen, name: "Sys.Green"),
            ColorModel(color: .systemBlue, name: "Sys.Blue"),
            ColorModel(color: .systemOrange, name: "Sys.Orange"),
            ColorModel(color: .systemYellow, name: "Sys.Yellow"),
            ColorModel(color: .systemPink, name: "Sys.Pink"),
            ColorModel(color: .systemPurple, name: "Sys.Purple"),
            ColorModel(color: .systemTeal, name: "Sys.Teal"),
            ColorModel(color: .systemIndigo, name: "Sys.Indigo"),
            
            ColorModel(color: .systemGray, name: "Sys.Gray"),
            ColorModel(color: .systemGray2, name: "Sys.Gray2"),
            ColorModel(color: .systemGray3, name: "Sys.Gray3"),
            ColorModel(color: .systemGray4, name: "Sys.Gray4"),
            ColorModel(color: .systemGray5, name: "Sys.Gray5"),
            ColorModel(color: .systemGray6, name: "Sys.Gray6"),
            
            // Separators
            ColorModel(color: .separator, name: "Separator"),
            ColorModel(color: .opaqueSeparator, name: "Opaque Sep."),
            
            // Backgrounds
            ColorModel(color: .systemBackground, name: "Sys.Background"),
            ColorModel(color: .secondarySystemBackground, name: "Sec.Sys.Background"),
            ColorModel(color: .tertiarySystemBackground, name: "Tert.Sys.Background"),
            
            // Grouped backgrounds
            ColorModel(color: .systemGroupedBackground, name: "Sys.Group.Background"),
            ColorModel(color: .secondarySystemGroupedBackground, name: "Sec.Sys.Group.Background"),
            ColorModel(color: .tertiarySystemGroupedBackground, name: "Tert.Sys.Group.Background"),
            
            // System fills
            ColorModel(color: .systemFill, name: "Sys.Fill"),
            ColorModel(color: .secondarySystemFill, name: "Sec.Sys.Fill"),
            ColorModel(color: .tertiarySystemFill, name: "Tert.Sys.Fill"),
            ColorModel(color: .quaternarySystemFill, name: "Quat.Sys.Fill"),
        ]
        #endif
    }
}

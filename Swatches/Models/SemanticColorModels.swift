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
    static func semanticColors() -> [ColorModel] {
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
            
            // TODO: Move these into a TextModel object
//            public static let label = Color(UIColor.label)
//            public static let secondaryLabel = Color(UIColor.secondaryLabel)
//            public static let tertiaryLabel = Color(UIColor.tertiaryLabel)
//            public static let quaternaryLabel = Color(UIColor.quaternaryLabel)
//            public static let link = Color(UIColor.link)
//            public static let placeholderText = Color(UIColor.placeholderText)
            
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
    }
}

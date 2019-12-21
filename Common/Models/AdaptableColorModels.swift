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
            ColorModel(color: .systemRed, name: "Sys.Red", supportedOS: .notWatch),
            ColorModel(color: .systemGreen, name: "Sys.Green", supportedOS: .notWatch),
            ColorModel(color: .systemBlue, name: "Sys.Blue", supportedOS: .notWatch),
            ColorModel(color: .systemOrange, name: "Sys.Orange", supportedOS: .notWatch),
            ColorModel(color: .systemYellow, name: "Sys.Yellow", supportedOS: .notWatch),
            ColorModel(color: .systemPink, name: "Sys.Pink", supportedOS: .notWatch),
            ColorModel(color: .systemPurple, name: "Sys.Purple", supportedOS: .notWatch),
            ColorModel(color: .systemTeal, name: "Sys.Teal", supportedOS: .notWatch),
            ColorModel(color: .systemIndigo, name: "Sys.Indigo", supportedOS: .notWatch),
            
            ColorModel(color: .systemGray, name: "Sys.Gray", supportedOS: .notWatch),
            
            // Separators
            ColorModel(color: .separator, name: "Separator", supportedOS: .notWatch),
            ColorModel(color: .opaqueSeparator, name: "Opaque Sep.", supportedOS: .notWatch),
        ]
        #else
        return [
            ColorModel(color: .systemRed, name: "Sys.Red", supportedOS: .notWatch),
            ColorModel(color: .systemGreen, name: "Sys.Green", supportedOS: .notWatch),
            ColorModel(color: .systemBlue, name: "Sys.Blue", supportedOS: .notWatch),
            ColorModel(color: .systemOrange, name: "Sys.Orange", supportedOS: .notWatch),
            ColorModel(color: .systemYellow, name: "Sys.Yellow", supportedOS: .notWatch),
            ColorModel(color: .systemPink, name: "Sys.Pink", supportedOS: .notWatch),
            ColorModel(color: .systemPurple, name: "Sys.Purple", supportedOS: .notWatch),
            ColorModel(color: .systemTeal, name: "Sys.Teal", supportedOS: .notWatch),
            ColorModel(color: .systemIndigo, name: "Sys.Indigo", supportedOS: .notWatch),
            
            ColorModel(color: .systemGray, name: "Sys.Gray", supportedOS: .notWatch),
            ColorModel(color: .systemGray2, name: "Sys.Gray2", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray3, name: "Sys.Gray3", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray4, name: "Sys.Gray4", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray5, name: "Sys.Gray5", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray6, name: "Sys.Gray6", supportedOS: .iOSAndMac),
            
            // Worth noting: Apple lists all of the following colors as "UI Element Colors", but they do all
            // adapt to dark mode, and none of them are supported on watchOS, so I put them under the
            // "Adaptive" label for the purposes of Swatches.
            
            // Separators
            ColorModel(color: .separator, name: "Separator", supportedOS: .notWatch),
            ColorModel(color: .opaqueSeparator, name: "Opaque Sep.", supportedOS: .notWatch),
            
            // Backgrounds
            ColorModel(color: .systemBackground, name: "Sys.Background", supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemBackground, name: "Sec.Sys.Background", supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemBackground, name: "Tert.Sys.Background", supportedOS: .iOSAndMac),
            
            // Grouped backgrounds
            ColorModel(color: .systemGroupedBackground,
                       name: "Sys.Group.Background",
                       supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemGroupedBackground,
                       name: "Sec.Sys.Group.Background",
                       supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemGroupedBackground,
                       name: "Tert.Sys.Group.Background",
                       supportedOS: .iOSAndMac),
            
            // System fills
            ColorModel(color: .systemFill, name: "Sys.Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemFill, name: "Sec.Sys.Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemFill, name: "Tert.Sys.Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .quaternarySystemFill, name: "Quat.Sys.Fill", supportedOS: .iOSAndMac),
        ]
        #endif
    }
}

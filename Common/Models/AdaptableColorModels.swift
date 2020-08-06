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
        #if os(watchOS)
        return [] // watchOS doesn't support the adaptable colors.
        #elseif os(tvOS) // tvOS only supports a subset of the adaptable colors.
        return [
            ColorModel(color: .systemRed, name: "System Red", supportedOS: .notWatch),
            ColorModel(color: .systemGreen, name: "System Green", supportedOS: .notWatch),
            ColorModel(color: .systemBlue, name: "System Blue", supportedOS: .notWatch),
            ColorModel(color: .systemOrange, name: "System Orange", supportedOS: .notWatch),
            ColorModel(color: .systemYellow, name: "System Yellow", supportedOS: .notWatch),
            ColorModel(color: .systemPink, name: "System Pink", supportedOS: .notWatch),
            ColorModel(color: .systemPurple, name: "System Purple", supportedOS: .notWatch),
            ColorModel(color: .systemTeal, name: "System Teal", supportedOS: .notWatch),
            ColorModel(color: .systemIndigo, name: "System Indigo", supportedOS: .notWatch),
            
            ColorModel(color: .systemGray, name: "System Gray", supportedOS: .notWatch),
            
            // Separators
            ColorModel(color: .separator, name: "Separator", supportedOS: .notWatch),
            ColorModel(color: .opaqueSeparator, name: "Opaque Separator", supportedOS: .notWatch),
        ]
        #else
        return [
            ColorModel(color: .systemRed, name: "System Red", supportedOS: .notWatch),
            ColorModel(color: .systemGreen, name: "System Green", supportedOS: .notWatch),
            ColorModel(color: .systemBlue, name: "System Blue", supportedOS: .notWatch),
            ColorModel(color: .systemOrange, name: "System Orange", supportedOS: .notWatch),
            ColorModel(color: .systemYellow, name: "System Yellow", supportedOS: .notWatch),
            ColorModel(color: .systemPink, name: "System Pink", supportedOS: .notWatch),
            ColorModel(color: .systemPurple, name: "System Purple", supportedOS: .notWatch),
            ColorModel(color: .systemTeal, name: "System Teal", supportedOS: .notWatch),
            ColorModel(color: .systemIndigo, name: "System Indigo", supportedOS: .notWatch),
            
            ColorModel(color: .systemGray, name: "System Gray", supportedOS: .notWatch),
            ColorModel(color: .systemGray2, name: "System Gray2", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray3, name: "System Gray3", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray4, name: "System Gray4", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray5, name: "System Gray5", supportedOS: .iOSAndMac),
            ColorModel(color: .systemGray6, name: "System Gray6", supportedOS: .iOSAndMac),
            
            // Worth noting: Apple lists all of the following colors as "UI Element Colors", but they do all
            // adapt to dark mode, and none of them are supported on watchOS, so I put them under the
            // "Adaptive" label for the purposes of Swatches.
            
            // Separators
            ColorModel(color: .separator, name: "Separator", supportedOS: .notWatch),
            ColorModel(color: .opaqueSeparator, name: "Opaque Separator", supportedOS: .notWatch),
            
            // Backgrounds
            ColorModel(color: .systemBackground, name: "System Background", supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemBackground, name: "Secondary System Background", supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemBackground, name: "Tertiary System Background", supportedOS: .iOSAndMac),
            
            // Grouped backgrounds
            ColorModel(color: .systemGroupedBackground,
                       name: "System Group Background",
                       supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemGroupedBackground,
                       name: "Secondary System Group Background",
                       supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemGroupedBackground,
                       name: "Tertiary System Group Background",
                       supportedOS: .iOSAndMac),
            
            // System fills
            ColorModel(color: .systemFill, name: "System Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .secondarySystemFill, name: "Secondary System Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .tertiarySystemFill, name: "Tertiary System Fill", supportedOS: .iOSAndMac),
            ColorModel(color: .quaternarySystemFill, name: "Quaternary System Fill", supportedOS: .iOSAndMac),
        ]
        #endif
    }
}

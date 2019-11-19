//
//  Color+UIColor.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-15.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

/// Color definitions of the UIColor constant colors.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {
    // Semantic colors
    public static let systemRed = Color(UIColor.systemRed)
    public static let systemGreen = Color(UIColor.systemGreen)
    public static let systemBlue = Color(UIColor.systemBlue)
    public static let systemOrange = Color(UIColor.systemOrange)
    public static let systemYellow = Color(UIColor.systemYellow)
    public static let systemPink = Color(UIColor.systemPink)
    public static let systemPurple = Color(UIColor.systemPurple)
    public static let systemTeal = Color(UIColor.systemTeal)
    public static let systemIndigo = Color(UIColor.systemIndigo)
    
    // Semantic grayscales
    public static let systemGray = Color(UIColor.systemGray)
    public static let systemGray2 = Color(UIColor.systemGray2)
    public static let systemGray3 = Color(UIColor.systemGray3)
    public static let systemGray4 = Color(UIColor.systemGray4)
    public static let systemGray5 = Color(UIColor.systemGray5)
    public static let systemGray6 = Color(UIColor.systemGray6)

    // Text colors
    public static let label = Color(UIColor.label)
    public static let secondaryLabel = Color(UIColor.secondaryLabel)
    public static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    public static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    public static let link = Color(UIColor.link)
    public static let placeholderText = Color(UIColor.placeholderText)
    // You could put lightText and darkText here, but they are basically deprecated in favor of label now.

    // Separators
    public static let separator = Color(UIColor.separator)
    public static let opaqueSeparator = Color(UIColor.opaqueSeparator)

    // Backgrounds
    public static let systemBackground = Color(UIColor.systemBackground)
    public static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    public static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    // Grouped backgrounds
    public static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    public static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    public static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)

    // System fills
    public static let systemFill = Color(UIColor.systemFill)
    public static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    public static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    public static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
}


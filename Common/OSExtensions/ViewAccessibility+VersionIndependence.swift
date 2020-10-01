//
//  ViewAccessibility+VersionIndependence.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-10-01.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// Provides iOS 13/14 (and matching watchOS or tvOS where appropriate) version independence for accessibility modifiers.
extension View {
    /// Wraps iOS 14 `accessibilityLabel` & iOS 13 `accessibility(label:)` into a single function that takes a string and applies the proper
    /// modifier.
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessbility label.
    /// - Returns: The modified view.
    func accessibility<S>(labelString: S) -> ModifiedContent<Self, AccessibilityAttachmentModifier> where S: StringProtocol {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityLabel(labelString)
        } else {
            return self.accessibility(label: Text(labelString))
        }
    }

    /// Wraps iOS 14 `accessibilityHint` & iOS 13 `accessibility(hint:)` into a single function that takes a string and applies the proper
    /// modifier.
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessbility hint.
    /// - Returns: The modified view.
    func accessibility<S>(hintString: S) -> ModifiedContent<Self, AccessibilityAttachmentModifier> where S: StringProtocol {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityHint(hintString)
        } else {
            return self.accessibility(hint: Text(hintString))
        }
    }

    /// Wraps iOS 14 `accessibilitySortPriority` & iOS 13 `accessibility(sortPriority:)` into a single function that takes a string and
    /// applies the proper modifier.
    /// - Parameter sortPriority: Something that conforms to `StringProtocol` that will be applies as the accessbility hint.
    /// - Returns: The modified view.
    func accessibilitySort(priority: Double) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilitySortPriority(priority)
        } else {
            return self.accessibility(sortPriority: priority)
        }
    }
}

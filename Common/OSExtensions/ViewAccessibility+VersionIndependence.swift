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
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessibility label.
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
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessibility hint.
    /// - Returns: The modified view.
    func accessibility<S>(hintString: S) -> ModifiedContent<Self, AccessibilityAttachmentModifier> where S: StringProtocol {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityHint(hintString)
        } else {
            return self.accessibility(hint: Text(hintString))
        }
    }

    /// Wraps iOS 14 `accessibilitySortPriority` & iOS 13 `accessibility(sortPriority:)` into a single function that takes a `Double` and
    /// applies the proper modifier.
    /// - Parameter sortPriority: The sort priority to apply to the content.
    /// - Returns: The modified view.
    func accessibilitySort(priority: Double) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilitySortPriority(priority)
        } else {
            return self.accessibility(sortPriority: priority)
        }
    }

    /// Wraps iOS 14 `accessibilityHidden` & iOS 13 `accessibility(hidden:)` into a single function that takes a bool and
    /// applies the proper modifier.
    /// - Parameter hideStatus: The bool that controls whether the view is hidden from accessibility.
    /// - Returns: The modified view.
    func accessibilityHide(hideStatus: Bool) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityHidden(hideStatus)
        } else {
            return self.accessibility(hidden: hideStatus)
        }
    }
}

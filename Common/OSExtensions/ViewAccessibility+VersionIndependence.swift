//
//  ViewAccessibility+VersionIndependence.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-10-01.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// Provides iOS 13/14 (and matching watchOS or tvOS where appropriate) version independence for accessibility modifiers.
/// - NOTE: the macCatalyst version of these are broken. We're targeting iOS 13 as a deploy target, but the #available checks below incorrectly claim that
///     macCatalyst 13 supports the new accessibilityFoo functions which are only available if we are running on macOS 11.0. So these functions all use the iOS
///     13 calls when on the macCatalyst target, without using the `#available` check..
extension View {
    /// Wraps iOS 14 `accessibilityLabel` & iOS 13 `accessibility(label:)` into a single function that takes a string and applies the proper
    /// modifier.
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessibility label.
    /// - Returns: The modified view.
    func accessibility<S>(labelString: S) -> ModifiedContent<Self, AccessibilityAttachmentModifier> where S: StringProtocol {
        #if targetEnvironment(macCatalyst)
        // See comment at top of extension for justifying this.
        return self.accessibility(label: Text(labelString))
        #else
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityLabel(labelString)
        } else {
            return self.accessibility(label: Text(labelString))
        }
        #endif
    }

    /// Wraps iOS 14 `accessibilityHint` & iOS 13 `accessibility(hint:)` into a single function that takes a string and applies the proper
    /// modifier.
    /// - Parameter labelString: Something that conforms to `StringProtocol` that will be applies as the accessibility hint.
    /// - Returns: The modified view.
    func accessibility<S>(hintString: S) -> ModifiedContent<Self, AccessibilityAttachmentModifier> where S: StringProtocol {
        #if targetEnvironment(macCatalyst)
        // See comment at top of extension for justifying this.
        return self.accessibility(hint: Text(hintString))
        #else
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityHint(hintString)
        } else {
            return self.accessibility(hint: Text(hintString))
        }
        #endif
    }

    /// Wraps iOS 14 `accessibilitySortPriority` & iOS 13 `accessibility(sortPriority:)` into a single function that takes a `Double` and
    /// applies the proper modifier.
    /// - Parameter sortPriority: The sort priority to apply to the content.
    /// - Returns: The modified view.
    func accessibilitySort(priority: Double) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        #if targetEnvironment(macCatalyst)
        // See comment at top of extension for justifying this.
        return self.accessibility(sortPriority: priority)
        #else
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilitySortPriority(priority)
        } else {
            return self.accessibility(sortPriority: priority)
        }
        #endif
    }

    /// Wraps iOS 14 `accessibilityHidden` & iOS 13 `accessibility(hidden:)` into a single function that takes a bool and
    /// applies the proper modifier.
    /// - Parameter hideStatus: The bool that controls whether the view is hidden from accessibility.
    /// - Returns: The modified view.
    func accessibilityHide(hideStatus: Bool) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        #if targetEnvironment(macCatalyst)
        // See comment at top of extension for justifying this.
        return self.accessibility(hidden: hideStatus)
        #else
        if #available(iOS 14, watchOS 7, tvOS 14, *) {
            return self.accessibilityHidden(hideStatus)
        } else {
            return self.accessibility(hidden: hideStatus)
        }
        #endif
    }
}

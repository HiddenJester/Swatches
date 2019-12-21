//
//  SupportedOSOptions.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-17.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

/// An `OptionSet` that lists the possible OS options for a particular color.
struct SupportedOSOptions: OptionSet {
    let rawValue: Int
    
    /// Does iOS support this color?
    static let iOS = SupportedOSOptions(rawValue: 1 << 0)

    /// Does macOS (via Catalyst) support this color?
    static let macOS = SupportedOSOptions(rawValue: 1 << 1)
    
    /// Does watchOS support this color?
    static let watchOS = SupportedOSOptions(rawValue: 1 << 2)
    
    /// Does tvOS support this color?
    static let tvOS = SupportedOSOptions(rawValue: 1 << 3)
    
    /// Useful set listing all four options.
    static let all: SupportedOSOptions = [.iOS, .macOS, .watchOS, .tvOS]
    
    /// Useful set listing both iOS and macOS, but not watchOS or tvOS.
    static let iOSAndMac: SupportedOSOptions = [.iOS, .macOS]
    
    /// watchOS is the most limited, particular in terms of it doesn't support dark/light mode so the whole "adaptable" set of colors is missing.
    /// This is the useful set of "everything but watchOS".
    /// - Note: Be careful here though. tvOS has a weird sub-set of adaptable colors, so cross-check using this carefully, versus `.iOSAndMac`.
    static let notWatch: SupportedOSOptions = [.iOS, .macOS, .tvOS]
}

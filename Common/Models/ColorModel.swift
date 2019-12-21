//
//  ColorModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

/// The data needed to render a `ColorSwatch`.
struct ColorModel: SwatchModel {
    /// The `Color` to draw in the `ColorChip`.
    let color: Color
    
    /// The name to display in the `SwatchLabel`.
    let name: String
    
    /// The supported OS information to draw in the Swatch.
    let supportedOS: SupportedOSOptions
}

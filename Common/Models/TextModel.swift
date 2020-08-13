//
//  TextModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

/// The data needed to render a `TextSwatch`.
struct TextModel: SwatchModel {
    /// The `Color` the `TextChip` needs to use for the text color.
    let color: Color
    
    /// The name to display in the `SwatchLabel` view.
    let name: String
    
    /// The supported OS information to draw in the Swatch.
    let supportedOS: SupportedOSOptions
}

extension TextModel: Hashable {}

extension TextModel {
    /// A model used to create a sample swatch with a reasonably long single line name.
    static let widthSample: TextModel = { TextModel(color: .clear, name: "Tertiary", supportedOS: .all) }()
}


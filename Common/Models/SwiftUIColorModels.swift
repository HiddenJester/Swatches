//
//  SwiftUIColorModels.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

extension ColorModel {
    /// All of the Color definitions provided by Swift UI.
    /// - Returns: An array of `ColorModel` that represents all of the available colors.
    static func swiftUIColors() -> [ColorModel] {
        [
            ColorModel(color: .clear, name: "Clear", supportedOS: .all),
            ColorModel(color: .black, name: "Black", supportedOS: .all),
            ColorModel(color: .white, name: "White", supportedOS: .all),
            ColorModel(color: .gray, name: "Gray", supportedOS: .all),
            ColorModel(color: .red, name: "Red", supportedOS: .all),
            ColorModel(color: .green, name: "Green", supportedOS: .all),
            ColorModel(color: .blue, name: "Blue", supportedOS: .all),
            ColorModel(color: .orange, name: "Orange", supportedOS: .all),
            ColorModel(color: .yellow, name: "Yellow", supportedOS: .all),
            ColorModel(color: .pink, name: "Pink", supportedOS: .all),
            ColorModel(color: .purple, name: "Purple", supportedOS: .all),
            ColorModel(color: .primary, name: "Primary", supportedOS: .all),
            ColorModel(color: .secondary, name: "Secondary", supportedOS: .all),
            
            ColorModel(color: .accentColor, name: "AccentColor", supportedOS: .all),
        ]
    }
    
}

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
    static func swiftUIColors() -> [ColorModel] {
        [
            ColorModel(color: .clear, name: "Clear"),
            ColorModel(color: .black, name: "Black"),
            ColorModel(color: .white, name: "White"),
            ColorModel(color: .gray, name: "Gray"),
            ColorModel(color: .red, name: "Red"),
            ColorModel(color: .green, name: "Green"),
            ColorModel(color: .blue, name: "Blue"),
            ColorModel(color: .orange, name: "Orange"),
            ColorModel(color: .yellow, name: "Yellow"),
            ColorModel(color: .pink, name: "Pink"),
            ColorModel(color: .purple, name: "Purple"),
            ColorModel(color: .primary, name: "Primary"),
            ColorModel(color: .secondary, name: "Secondary"),
            
            ColorModel(color: .accentColor, name: "Accent"),
        ]
    }
    
}

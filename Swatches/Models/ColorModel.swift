//
//  ColorModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

struct ColorModel {
    let id = UUID()
    
    let color: Color
    
    let name: String
    
    let invertBackground: Bool
}

extension ColorModel: Identifiable {}

extension ColorModel {
    static func previewModels() -> [ColorModel] {
        return [
            ColorModel(color: .blue, name: "Blue", invertBackground: false),
            ColorModel(color: .green, name: "Green", invertBackground: false),
            ColorModel(color: .black, name: "Black", invertBackground: false),
            ColorModel(color: .accentColor, name: "Accent", invertBackground: false),
            ColorModel(color: .orange, name: "Orange", invertBackground: false),
        ]
    }
}

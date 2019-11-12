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
    static func swiftUIColors() -> [ColorModel] {
        return [
            ColorModel(color: .clear, name: "Clear", invertBackground: false),
            ColorModel(color: .black, name: "Black", invertBackground: false),
            ColorModel(color: .white, name: "White", invertBackground: false),
            ColorModel(color: .gray, name: "Gray", invertBackground: true),
            ColorModel(color: .red, name: "Red", invertBackground: false),
            ColorModel(color: .green, name: "Green", invertBackground: false),
            ColorModel(color: .blue, name: "Blue", invertBackground: false),
            ColorModel(color: .orange, name: "Orange", invertBackground: false),
            ColorModel(color: .yellow, name: "Yellow", invertBackground: false),
            ColorModel(color: .pink, name: "Pink", invertBackground: false),
            ColorModel(color: .purple, name: "Purple", invertBackground: false),
            ColorModel(color: .primary, name: "Primary", invertBackground: false),
            ColorModel(color: .secondary, name: "Secondary", invertBackground: false),
        ]
    }
}
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

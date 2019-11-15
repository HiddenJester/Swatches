//
//  SemanticColorModels.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-14.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

extension ColorModel {
    static func semanticColors() -> [ColorModel] {
        return [
            ColorModel(color: .systemRed, name: "System Red"),
            ColorModel(color: .systemGreen, name: "System Green"),
            ColorModel(color: .systemBlue, name: "System Blue"),
            ColorModel(color: .systemOrange, name: "System Orange"),
            ColorModel(color: .systemYellow, name: "System Yellow"),
            ColorModel(color: .systemPink, name: "System Pink"),
            ColorModel(color: .systemPurple, name: "System Purple"),
            ColorModel(color: .systemTeal, name: "System Teal"),
            ColorModel(color: .systemIndigo, name: "System Indigo"),
        ]
    }
}

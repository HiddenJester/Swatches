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
            ColorModel(color: Color(UIColor.systemRed), name: "System Red"),
            ColorModel(color: Color(UIColor.systemGreen), name: "System Green"),
            ColorModel(color: Color(UIColor.systemBlue), name: "System Blue"),
            ColorModel(color: Color(UIColor.systemOrange), name: "System Orange"),
            ColorModel(color: Color(UIColor.systemYellow), name: "System Yellow"),
            ColorModel(color: Color(UIColor.systemPink), name: "System Pink"),
            ColorModel(color: Color(UIColor.systemPurple), name: "System Purple"),
            ColorModel(color: Color(UIColor.systemTeal), name: "System Teal"),
            ColorModel(color: Color(UIColor.systemIndigo), name: "System Indigo"),
        ]
    }
}

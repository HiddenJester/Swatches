//
//  TextModels.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

extension TextModel {
    static func textModels() -> [TextModel] {
        [
            TextModel(color: .label, name: "Label"),
            TextModel(color: .label, name: "Sec.Label"),
            TextModel(color: .label, name: "Tert.Label"),
            TextModel(color: .label, name: "Quat.Label"),
            TextModel(color: .label, name: "Link"),
            TextModel(color: .label, name: "PlaceholderText"),
        ]
    }
}

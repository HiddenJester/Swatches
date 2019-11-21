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
            TextModel(color: .secondaryLabel, name: "Sec.Label"),
            TextModel(color: .tertiaryLabel, name: "Tert.Label"),
            TextModel(color: .quaternaryLabel, name: "Quat.Label"),
            TextModel(color: .link, name: "Link"),
            TextModel(color: .placeholderText, name: "PlaceholderText"),
        ]
    }
}

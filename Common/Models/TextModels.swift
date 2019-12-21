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
    /// The "adaptable" text colors provided by UIKit. These all change when the color scheme is changed from light to dark. Note that these models rely
    /// on the mapping from `UIColor` to `Color`provided by Color+UIColor.swift. Also note that these are just the colors intended for text rendering.
    /// The other colors are provided in `adaptableColors()`.
    /// - Returns: An array of `TextModel` that represents all of the adaptable colors intended for text rendering..
    static func textModels() -> [TextModel] {
        [
            TextModel(color: .label, name: "Label", supportedOS: .notWatch),
            TextModel(color: .secondaryLabel, name: "Sec.Label", supportedOS: .notWatch),
            TextModel(color: .tertiaryLabel, name: "Tert.Label", supportedOS: .notWatch),
            TextModel(color: .quaternaryLabel, name: "Quat.Label", supportedOS: .notWatch),
            TextModel(color: .link, name: "Link", supportedOS: .notWatch),
            TextModel(color: .placeholderText, name: "PlaceholderText", supportedOS: .notWatch),
        ]
    }
}

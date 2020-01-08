//
//  GridModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

/// Empty protocol that swatch model objects can conform to. Conforming to `SwatchModel` means the object is suitable for inclusion in
/// `GridModel.models`.
protocol SwatchModel {}

/// The data needed to render a `SwatchGrid` of some ilk. The type of data stored in `models` will be used by `MainView` to determine the type of the
/// grid that will be displayed.
struct GridModel {
    let id = UUID()
    
    /// The name of the grid.
    let name: String
    
    /// The models that should be rendered when the grid is shown.
    let models: [SwatchModel]
}

extension GridModel: Identifiable {}

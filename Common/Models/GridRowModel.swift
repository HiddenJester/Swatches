//
//  SwatchGridRowModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

/// A generic struct that stores objects that conform to `SwatchModel`. A `SwatchGrid` can loop through a series of `GridRowModel` and draw
/// the related content. Note that `GridRowModel` has no preference whether the contents should be displayed in one or two columns.
struct GridRowModel<Model: SwatchModel> {
    /// The ID. Needed to conform to `Identifiable`, which is needed so a SwiftUI `ForEach` can iterate over an array of `GridRowModel` objects.
    let id = UUID()
    
    /// The first `SwatchModel` to display for this row.
    let first: Model?
    
    /// The second `SwatchModel` to display for this row.
    let second: Model?
}

extension GridRowModel: Identifiable {}

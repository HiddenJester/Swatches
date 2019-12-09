//
//  ColorSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A "grid" view that draws `ColorSwatch` objects. This is accomplished by iterating over an array of `GridRowModel<ColorModel>` objects, which
/// and drawing a `ColorGridRow` for each row model. Since a `ColorGridRow` will draw 2 columns of swatches, this has the effect of presenting a
/// two-column faux "grid". Look at `ColorSwatchGrid.mapColorsToRows(colorModels:)` as a useful helper function that can turn an array
/// of `ColorModel` objects into `GridRowModel` objects suitable for rendering.
struct ColorSwatchGridView: View {
    /// A useful alias that lets us specialize the GridRowModel objects used throughout the grid.
    typealias RowModel = GridRowModel<ColorModel>
    
    /// The `GridRowModel` objects that will be used to draw the `ColorGridRow` views.
    let rowModels: [RowModel]
    
    var body: some View {
        ScrollView {
            ForEach(rowModels) { model in
                FocusableGridRowView {
                    ColorGridRowView(first: model.first, second: model.second)
                    
                }
                
            }

        }
    }
}

extension ColorSwatchGridView {
    /// A static function that conceptually maps an array of `ColorModel` into an array of `RowModel` objects.
    /// - Parameter colorModels: The array of `ColorModel` objects used to create the `RowModel` output.
    /// - Returns: An array of `RowModel` objects.
    /// - Note: This is "conceptual" map, not a literal map. The reason for this is that the output count will be 1/2 of the input's count. Also note that
    ///     `colorModels` order will be preserved, such that the first row in the output will be the first and second object in `colorModels`, and the
    ///     second row will be the third and fourth subscript and so forth. If `colorModels.count` is odd then the final row will have a blank, transparent
    ///     swatch rendered in the right column.
    static func mapColorsToRows(colorModels: [ColorModel]) -> [RowModel] {
        var rows = [RowModel]()

        (0 ..< colorModels.count / 2).forEach { rowIndex in
            let firstIndex = rowIndex * 2
            rows.append(GridRowModel(first: colorModels[firstIndex], second: colorModels[firstIndex + 1]))
        }

        // Catch the odd one out
        if !colorModels.count.isMultiple(of: 2) {
            rows.append(GridRowModel(first: colorModels.last!, second: nil))
        }

        return rows
    }
}

struct ColorSwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ColorSwatchGridView(rowModels: ColorSwatchGridView.mapColorsToRows(colorModels: ColorModel.swiftUIColors()))
        }
    }
}

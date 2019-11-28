//
//  TextSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A "grid" view that draws `TextSwatch` objects. This is accomplished by iterating over an array of `GridRowModel<TextModel>` objects, which
/// and drawing a `TextGridRow` for each row model. Currently we draw `TextSwatches` in a single column, so `TextGridRow` isn't strictly
/// necessary, but this logic separates the view construction from the detail of how many columns we want to draw. In order to preserve this
/// `TextSwatchGrid.mapTextsToRow(textModels)` is a useful helper function that encapsulates knowing how many models are presented per
/// "grid" row.
/// - Parameter rowModels: The raw `GridRowModel<TextModel>` objects that need to be rendered.
struct TextSwatchGrid: View {
    /// A useful alias that lets us specialize the GridRowModel objects used throughout the grid.
    typealias RowModel = GridRowModel<TextModel>
    
    let rowModels: [RowModel]
    
    @State private var sample = "The quick brown fox jumps over the lazy dog."
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Sample:")
                    .font(.title)

                TextField("Sample Text:", text: $sample)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()

            }.overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
            
            ScrollView {
                ForEach(rowModels) { TextGridRow(model: $0.first, sample: self.sample) }
                
            }.padding(.vertical)
        }
    }
}

extension TextSwatchGrid {
    /// A static function that conceptually maps an array of `TextModel` into an array of `RowModel` objects.
    /// - Parameter textModels: The array of `TextModel` objects used to create the `RowModel` output.
    /// - Returns: An array of `RowModel` objects.
    /// - Note: This is "conceptual" map, not a literal map. In this *specific* case right now it is in fact a literal map, but using this function means we
    ///     could later change the number of columns presented in the grid just by adjusting this function.
    static func mapTextsToRows(textModels: [TextModel]) -> [RowModel] {
        let rows: [RowModel] = textModels.map { RowModel(first: $0, second: nil) }
        
        return rows
    }
}

struct TextSwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatchGrid(rowModels: TextSwatchGrid.mapTextsToRows(textModels: TextModel.textModels()))
    }
}

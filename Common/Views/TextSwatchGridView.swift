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
struct TextSwatchGridView: View {
    /// A useful alias that lets us specialize the GridRowModel objects used throughout the grid.
    typealias RowModel = GridRowModel<TextModel>
    
    let rowModels: [RowModel]
    
    @State private var sample = "The quick brown fox jumps over the lazy dog."
    
    var body: some View {
        VStack {
            VStack(spacing: CGFloat(0)) {
                Text("Sample:")
                    .font(.title)

                TextField("Sample Text:", text: $sample)
                    .textFieldStyle(fieldStyle())
                    .disableAutocorrection(true)
                    .padding()

            }.overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
            .padding()
            
            ScrollView {
                ForEach(rowModels) { model in
                    FocusableGridRowView {
                        TextGridRowView(model: model.first, sample: self.sample)
                    }

                }
                
            }.padding(.vertical)
        }
    }
}

extension TextSwatchGridView {
    /// A static function that conceptually maps an array of `TextModel` into an array of `RowModel` objects.
    /// - Parameter textModels: The array of `TextModel` objects used to create the `RowModel` output.
    /// - Returns: An array of `RowModel` objects.
    /// - Note: This is "conceptual" map, not a literal map. In this *specific* case right now it is in fact a literal map, but using this function means we
    ///     could later change the number of columns presented in the grid just by adjusting this function.
    static func mapModelsToRows(_ textModels: [TextModel]) -> [RowModel] {
        let rows: [RowModel] = textModels.map { RowModel(first: $0, second: nil) }
        
        return rows
    }
}

private extension TextSwatchGridView {
    /// Creates a platform specific `TextFieldStyle` suitable for the sample text field.
    /// - Returns: On iOS or macOS this will return `RoundedBorderTestFieldStyle`. Since other platforms don't support this style
    ///     on other platforms this returns `DefaultTextFieldStyle`.
    func fieldStyle() -> some TextFieldStyle {
        #if os(iOS) || targetEnvironment(macCatalyst)
        return RoundedBorderTextFieldStyle()
        #else
        return DefaultTextFieldStyle()
        #endif
    }
}
struct TextSwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatchGridView(rowModels: TextSwatchGridView.mapModelsToRows(TextModel.textModels()))
    }
}

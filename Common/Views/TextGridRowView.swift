//
//  TextGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that displays a `TextSwatch`. Unlike the `ColorGridRow`, the `TextGridRow` only displays a single column of swatches.
/// - Parameter model: The `TextModel` that will be drawn in this row's swatch.
/// - Parameter sample: The string to draw in the swatch.
struct TextGridRowView: View {
    /// The TextModel that lists the color and label to use for the swatch.
    let model: TextModel?

    /// The string that should be displayed in the swatch.
    let sample: String
    
    var body: some View {
        TextSwatchView(sample: sample, model: model)
            .padding()
    }
}

struct TextGridRow_Previews: PreviewProvider {
    static let models = TextModel.textModels()
    static let sample = "The quick brown fox jumps over the lazy dog."
    
    static var previews: some View {
        Group {
            TextGridRowView(model: models[0], sample: sample)

            TextGridRowView(model: models[4], sample: sample)
        }
    }
}

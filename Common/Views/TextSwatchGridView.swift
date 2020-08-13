//
//  TextSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A "grid" view that draws `TextSwatch` objects, along with a `TextField` for editing the sample string displayed in the swatches.
/// - Parameter models: The raw `TextModel` objects that need to be rendered.
struct TextSwatchGridView: View {
    /// The models to render in the grid.
    let models: [TextModel]
    
    /// The text to use as the sample for all of the swatches.
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

            }
            .overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
            .padding()
            
            FlowableContentGridView(models: models,
                                    widthSampleModel: TextModel.widthSample) { model in
                TextSwatchView(sample: self.sample, model: model)
            }
        }
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

struct TextSwatchGridView_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatchGridView(models: TextModel.textModels())
            .previewLayout(PreviewLayout.sizeThatFits)

    }
}

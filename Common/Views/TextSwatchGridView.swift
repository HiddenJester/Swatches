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
    // Screenshot variant
//    @State private var sample = "Dev Swatches"

    var body: some View {
        FlowableContentGridView(models: models,
                                widthSampleModel: TextModel.widthSample,
                                header: { self.headerView() }) {
                                    TextSwatchView(sample: self.sample, model: $0, width: $1)
        }
    }
}

private extension TextSwatchGridView {
    /// Creates the "header" view that contains the TextField for editing the sample text. This can be passed to the grid as a header view,
    /// allowing it to be placed inside the scroll view, which is handy for landscape on phones.
    /// - Returns: The header view with the bound `TextField`.
    func headerView() -> some View {
        VStack(spacing: 0) {
            Text("Sample:")
                .font(.title)

            TextField("Sample Text:", text: $sample)
                .accessibility(hintString: "Enter text to display in samples.")
                .textFieldStyle(fieldStyle())
                .disableAutocorrection(true)
                .padding()
        }
        .overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
        .padding()
    }

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

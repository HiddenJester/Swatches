//
//  TextSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A "grid" view that draws `TextSwatch` objects, along with a `TextField` for editing the sample string displayed in the swatches.
/// The swatches themselves are rendered in a `SwatchSingleColumnGridView`.
/// - Parameter rowModels: The raw `TextModel` objects that need to be rendered.
struct TextSwatchSingleColumnGridView: View {
    let rowModels: [TextModel]
    
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
                SwatchSingleColumnGridView(rowModels: rowModels) { (model) in
                    TextSwatchView(sample: self.sample, model: model)
                    
                }
                
            }.padding(.vertical)
        }
    }
}

private extension TextSwatchSingleColumnGridView {
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
struct TextSwatchSingleColumnGridView_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatchSingleColumnGridView(rowModels: TextModel.textModels())
    }
}

//
//  TextSwatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that displays a simple text swatch. It takes a `String` to display and a `TextModel` and draws a proper swatch. If the model is nil then the
/// swatch will still occupy space but will be completely transparent.
/// - Parameter sample: The string to display in the displayed text.
/// - Parameter model: The optional `TextModel` that provides the swatch label text and the color to display the text in.
struct TextSwatchView: View {
    /// The string to display in the swatch.
    let sample: String
    
    /// The text model to render in this swatch.
    let model: TextModel?

    var body: some View {
        SwatchView(drawBackground: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all) {
                TextChipView(text: self.sample, color: self.model?.color ?? .clear)

        }
    }
}

struct TextSwatch_Previews: PreviewProvider {
    static let sample = "The quick brown fox jumps over the lazy dog"
    static let model = TextModel(color: .link, name: "Link", supportedOS: [.iOS, .macOS, .tvOS])
    static var previews: some View {
        Group {
            TextSwatchView(sample: sample, model: model)

            TextSwatchView(sample: sample, model: model)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}

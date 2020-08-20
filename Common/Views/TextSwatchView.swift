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
struct TextSwatchView: View {
    /// The string to display in the swatch.
    let sample: String
    
    /// The text model to render in this swatch.
    let model: TextModel?

    /// Set a size to force the `TextSwatchView` to that size. If `.zero` or nil is set for the width then the swatch will determine a normal intrinsic size.
    let size: CGSize?

    var body: some View {
        SwatchView(drawBackgroundAndOutline: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all,
                   size: size) { TextChipView(text: self.sample, color: self.model?.color ?? .clear) }
    }
}

struct TextSwatch_Previews: PreviewProvider {
    static let sample = "The quick brown fox jumps over the lazy dog"
    static let model = TextModel(color: .link, name: "Link", supportedOS: [.iOS, .macOS, .tvOS])
    static var previews: some View {
        Group {
            TextSwatchView(sample: sample, model: model, size: nil)

            TextSwatchView(sample: sample, model: model, size: nil)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

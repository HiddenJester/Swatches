//
//  ColorSwatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that draws everything needed for a given `ColorModel`. A `Swatch` is created and the body of the `Swatch` will be a `ColorChip` object
/// representing the color in the model. If nil is provided for the model then an empty `Swatch` will be created, containing a transparent `ColorChip` with
/// no background.
struct ColorSwatchView: View {
    /// The `ColorModel` that will be rendered in this swatch.
    let model: ColorModel?
    
    /// The maxWidth to use for the swatch.
    let maxWidth: CGFloat
    
    var body: some View {
        SwatchView(drawBackground: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all,
                   maxWidth: maxWidth) {
            if self.model != nil {
                ColorChipView(color: self.model!.color, drawBackground: true)
            } else {
                EmptyView()
            }
        }
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static let wordy = ColorModel(color: .blue, name: "Wordy Blue Label", supportedOS: .all)
    static let secondary = ColorModel(color: .secondary, name: "Secondary", supportedOS: .iOSAndMac)
    
    static var previews: some View {
        Group {
            HStack {
                ColorSwatchView(model: wordy, maxWidth: 150)

                ColorSwatchView(model: nil, maxWidth: 0)

                ColorSwatchView(model: secondary, maxWidth: 150)

            }

            HStack {
                ColorSwatchView(model: wordy, maxWidth: 150)

                ColorSwatchView(model: secondary, maxWidth: 150)

            }.environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")

        }
    }
}

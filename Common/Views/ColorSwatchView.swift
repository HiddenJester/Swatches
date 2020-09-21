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

    /// If a width is provided than the frame is locked to that value. A width of 0 or less is discarded by the `SwatchView`.
    let width: CGFloat?
    
    var body: some View {
        SwatchView(drawBackgroundAndOutline: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all,
                   width: width) {
            if let color = model?.color {
                ColorChipView(color: color, drawBackground: true)
            } else {
                ColorChipView(color: .clear, drawBackground: false)
            }
        }
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static let wordy = ColorModel(color: .green,
                                  name: "Tertiary System Background",
                                  supportedOS: .iOSAndMac)

    static let secondary = ColorModel(color: .secondary,
                                      name: "Secondary",
                                      supportedOS: .iOSAndMac)

    static let width: CGFloat = 200

    static var previews: some View {
        Group {
            HStack {
                ColorSwatchView(model: wordy, width: width)

                ColorSwatchView(model: nil, width: width)

                ColorSwatchView(model: secondary, width: width)
            }

            HStack {
                ColorSwatchView(model: wordy, width: width)

                ColorSwatchView(model: secondary, width: width)

            }
            .environment(\.colorScheme, .dark)
            .background(Color.black)
            .previewDisplayName("Dark Mode")

        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

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

    /// Set a size to force the `SwatchView` to that size. If `.zero` or nil is set for the width then the swatch will determine a normal intrinsic size.
    let size: CGSize?
    
    var body: some View {
        SwatchView(drawBackgroundAndOutline: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all,
                   size: size) {
            chipView(forColor: model?.color)
            // This doesn't work, see the HeaderDoc for chipView below.
//            if let color = model?.color {
//                ColorChipView(color: color, drawBackground: true)
//            } else {
//                ColorChipView(color: .clear, drawBackground: false)
//            }
        }
    }
}

private extension ColorSwatchView {
    /// In order to use a PreferenceKey every instance of `ColorSwatchView` must have the *exact same signature*. If this code is present inline in
    /// main function it affects the signature. So instead this is a separate function with a single signature. If a color is passed in, the regular
    /// `ColorChipView` is returned. If nil is passed in a clear chip with no background is returned.
    /// - Parameter color: A `Color?` to draw in the chip view. Pass `nil` to get a clear chip with no background.
    /// - Returns: An appropriate `ColorChipView`.
    func chipView(forColor color: Color?) -> ColorChipView {
        if let color = color {
            return ColorChipView(color: color, drawBackground: true)
        } else {
            return ColorChipView(color: .clear, drawBackground: false)
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

    static let size = CGSize(width: 200, height: 200)

    static var previews: some View {
        Group {
            HStack {
                ColorSwatchView(model: wordy, size: size)

                ColorSwatchView(model: nil, size: size)

                ColorSwatchView(model: secondary, size: size)
            }

            HStack {
                ColorSwatchView(model: wordy, size: size)

                ColorSwatchView(model: secondary, size: size)

            }
            .environment(\.colorScheme, .dark)
            .background(Color.black)
            .previewDisplayName("Dark Mode")

        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

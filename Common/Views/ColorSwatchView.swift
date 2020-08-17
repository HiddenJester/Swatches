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

    /// Set a width to force the `CikirSwatchView` to that width. If 0 or nil is set for the width then the swatch will determine a normal intrinsic size.
    let width: CGFloat?
    
    var body: some View {
        SwatchView(drawBackgroundAndOutline: model != nil,
                   label: model?.name ?? " ",
                   supportedOS: model?.supportedOS ?? .all,
                   width: width) {
            if self.model != nil {
                ColorChipView(color: self.model!.color, drawBackground: true)
            } else {
                EmptyView()
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
    
    static var previews: some View {
        Group {
            HStack {
                ColorSwatchView(model: wordy, width: nil)

                ColorSwatchView(model: nil, width: nil)

                ColorSwatchView(model: secondary, width: nil)

            }

            HStack {
                ColorSwatchView(model: wordy, width: nil)

                ColorSwatchView(model: secondary, width: nil)

            }
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark Mode")

        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

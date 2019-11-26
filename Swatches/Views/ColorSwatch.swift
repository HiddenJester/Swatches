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
struct ColorSwatch: View {
    /// The `ColorModel` that will be rendered in this swatch.
    let model: ColorModel?
    
    
    var body: some View {
        Swatch(drawBackground: model != nil, label: model?.name ?? " ") {
            if self.model != nil {
                ColorChip(color: self.model!.color, drawBackground: true)
            } else {
                ColorChip(color: .clear, drawBackground: false)
            }
        }
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Wordy But Normal"))
                ColorSwatch(model: ColorModel(color: .secondary, name: "Inverted"))
                ColorSwatch(model: nil)
            }.previewDevice("iPhone SE")

            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Normal"))
                ColorSwatch(model: ColorModel(color: .black, name: "Inverted"))
            }.previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
        }
    }
}

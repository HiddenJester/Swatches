//
//  ColorSwatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ColorSwatch: View {
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

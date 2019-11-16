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
    
    /// Padding edges for the ColorChip. It's only three edges because the label pads the bottom edge of the chip.
    private let chipPadding: Edge.Set = [.top, .leading, .trailing]
    
    private let cornerRadius = CGFloat(20.0)

    var body: some View {
        VStack() {
            if model != nil {
                ColorChip(color: model!.color, keyline: true)
                    .padding(chipPadding)
            } else {
                ColorChip(color: .clear, keyline: false)
                    .padding(chipPadding)
            }
            
            Text(model?.name ?? " ")
                .foregroundColor(Color(UIColor.label))
                .truncationMode(.middle)
                .lineLimit(1)
                .padding(.vertical)

        }.background(model != nil ? Color(UIColor.systemFill) : Color.clear)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(model != nil ? Color.primary : Color.clear, lineWidth: 2))
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

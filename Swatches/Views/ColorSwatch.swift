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
        VStack() {
            if model != nil {
                ColorChip(color: model!.color, keyline: true)
                    .padding()
            } else {
                ColorChip(color: .clear, keyline: false)
                    .padding()
            }
            
            Text(model?.name ?? " ")
                .foregroundColor(Color(UIColor.label))
                .font(.headline)
                .minimumScaleFactor(0.75)
                .padding(5)

        }.background(model != nil ? Color(UIColor.systemFill) : Color.clear)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(model != nil ? Color.primary : Color.clear, lineWidth: 2))
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Normal"))
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

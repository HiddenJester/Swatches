//
//  ColorSwatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ColorSwatch: View {
    let model: ColorModel
    
    var body: some View {
        VStack() {
            ColorChip(color: model.color)
                .padding()
            
            Text(model.name)
                .padding(.bottom)
                .foregroundColor(model.color)
            
        }.background(model.invertBackground ? Color.primary : Color.secondary)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary, lineWidth: 2))
            .padding()
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Blue", invertBackground: false))
                ColorSwatch(model: ColorModel(color: .green, name: "Green", invertBackground: true))
            }.previewDevice("iPhone SE")

            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Blue", invertBackground: false))
                ColorSwatch(model: ColorModel(color: .green, name: "Green", invertBackground: true))
            }.previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
        }
    }
}

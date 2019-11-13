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
            ColorChip(color: model?.color ?? .clear)
                .padding()
            
            Text(model?.name ?? " ")
                .padding(.bottom)
                .foregroundColor(Color(UIColor.label))
            
        }.background(backgroundColor())
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(strokeColor(), lineWidth: 2))
            .padding()
    }
    
    func backgroundColor() -> Color {
        guard let model = model else {
            return .clear
        }
        
        return model.invertBackground ? Color.primary : Color.secondary
    }
    
    func strokeColor() -> Color {
        model != nil ? .primary : .clear
    }
}

struct ColorSwatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Blue", invertBackground: false))
                ColorSwatch(model: ColorModel(color: .green, name: "Green", invertBackground: true))
                ColorSwatch(model: nil)
            }.previewDevice("iPhone SE")

            HStack {
                ColorSwatch(model: ColorModel(color: .blue, name: "Blue", invertBackground: false))
                ColorSwatch(model: ColorModel(color: .green, name: "Green", invertBackground: true))
            }.previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
        }
    }
}

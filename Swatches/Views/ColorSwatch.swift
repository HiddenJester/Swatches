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
                .padding(.bottom)
                .foregroundColor(Color(UIColor.label))
            
        }.background(background())
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(strokeColor(), lineWidth: 2))
            .padding()
    }
    
    func background() -> some View {
        guard self.model != nil else {
            return AnyView(EmptyView())
        }
        
        return AnyView(Image("Checkerboard")
            .resizable(resizingMode: .tile))
    }
    
    func strokeColor() -> Color {
        model != nil ? .primary : .clear
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

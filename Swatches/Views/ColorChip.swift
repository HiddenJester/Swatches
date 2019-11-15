//
//  ColorView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ColorChip: View {
    let color: Color
    let keyline: Bool
    
    @Environment(\.colorScheme) var scheme
    
    private let minSwatchSize = CGFloat(50)
    private let maxSwatchSize = CGFloat(300)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20.0)
            .frame(minWidth: minSwatchSize,
                   maxWidth: maxSwatchSize,
                   minHeight: minSwatchSize,
                   maxHeight: maxSwatchSize)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
            .scaledToFit()
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(keyline ? Color.black : Color.clear))
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChip(color: .green, keyline: true)
            ColorChip(color: .green, keyline: true)
                .previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
            ColorChip(color: .clear, keyline: false)
        }
    }
}

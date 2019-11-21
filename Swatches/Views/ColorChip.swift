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
    
    let drawBackground: Bool
    
    private let minChipEdge = CGFloat(50)
    
    private let maxChipEdge = CGFloat(300)
    
    private let cornerRadius = CGFloat(20.0)
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(minWidth: minChipEdge,
                   maxWidth: maxChipEdge,
                   minHeight: minChipEdge,
                   maxHeight: maxChipEdge)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
            .scaledToFit()
            .background(ChipBackground(drawCheckerboard: drawBackground, cornerRadius: cornerRadius))
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChip(color: .green, drawBackground: true)
            ColorChip(color: .green, drawBackground: true)
                .previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
            ColorChip(color: .clear, drawBackground: false)
        }
    }
}

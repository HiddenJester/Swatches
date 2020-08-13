//
//  ColorView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that draws a color "chip", potentially with a checkerboard background. The chip maintains a square aspect ratio. The color drawn is specified in the
/// `color` argument, and `drawBackground` controls whether the checkerboard and outline are drawn or not. The color chip is drawn with rounded corners.
/// - Note: `ColorChip(color: .clear, drawBackground: false)` creates a transparent chip (*not* an `EmptyView()`).
struct ColorChipView: View {
    /// The color to draw in the chip.
    let color: Color
    
    /// Set to true to draw the checkerboard background (and the outline).
    var drawBackground = true

    // Arbitrary value designed to not take up a ridiculous amount of space.
    #if os(tvOS)
    let maxWidth = CGFloat(100)
    #else
    let maxWidth = CGFloat(50)
    #endif
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
            .background(ChipBackgroundView(fillColor: drawBackground ? nil : .clear))
            .frame(maxWidth: maxWidth)
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChipView(color: .green)
            ColorChipView(color: .clear)
            ColorChipView(color: .clear, drawBackground: false)
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

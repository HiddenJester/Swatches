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
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20.0)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
            .background(ChipBackgroundView(fillColor: drawBackground ? nil : .clear))
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChipView(color: .green)
            ColorChipView(color: .clear)
            ColorChipView(color: .clear, drawBackground: false)
        }
    }
}

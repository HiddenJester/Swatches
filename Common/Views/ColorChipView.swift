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
            .overlay(RoundedRectangle(cornerRadius: 5.0)
                        .inset(by: 1)
                        .stroke(strokeColor(), lineWidth: 2)
            )
    }
}

private extension ColorChipView {
    /// Determine the proper color to use for the outline.
    /// - Returns: The color to pass when stroking the outline.
    func strokeColor() -> Color {
        if !drawBackground {
            return .clear
        } else {
            #if os(watchOS)
            return .black
            #else
            return .opaqueSeparator
            #endif
        }
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChipView(color: .blue)
            ColorChipView(color: .clear)
            ColorChipView(color: .clear, drawBackground: false)
        }
        .background(Color.green)
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

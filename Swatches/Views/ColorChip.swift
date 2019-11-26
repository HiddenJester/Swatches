//
//  ColorView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that draws a color "chip", potentially with a checkerboard background. The chip will will accept any size between 50 points and 300 points, but
/// will maintain a square aspect ratio. The color drawn is specified in the `color` argument, and `drawBackground` controls whether the checkerboard
/// and outline are drawn or not. The color chip is drawn with rounded corners.
/// - Note: `ColorChip(color: .clear, drawBackground: false)` creates a transparent chip (*not* an `EmptyView()`) that is sized as
///     described above.
struct ColorChip: View {
    /// The color to draw in the chip.
    let color: Color
    
    /// Set to true to draw the checkerboard background (and the outline).
    let drawBackground: Bool
    
    /// The minimum dimension a chip will accept.
    private let minChipEdge = CGFloat(50)
    
    /// The maxium dimension a chip will accept.
    private let maxChipEdge = CGFloat(300)
    
    /// The corner radius used for the Chip and the background.
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

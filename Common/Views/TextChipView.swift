//
//  TextChip.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that takes a string and a color and draws the text above a `ChipBackground` view.
/// - Parameter text: The string to display.
/// - Parameter color: the Color to draw the text in. If this is set to `.clear` then no background is drawn.
struct TextChipView: View {
    /// The string to display for the chip.
    let text: String
    
    /// The color to display the text in. If this is `.clear` then no background is drawn.
    let color: Color

    /// The corner radius to use on the `ChipBackground`.
    private let cornerRadius = CGFloat(20.0)

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(color)
            .background(ChipBackgroundView(drawCheckerboard: color != .clear, cornerRadius: cornerRadius))
    }
}

struct TextChip_Previews: PreviewProvider {
    static var previews: some View {
        TextChipView(text: "Testing", color: .link)
    }
}

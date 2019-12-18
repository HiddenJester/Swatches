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
    
    var body: some View {
        VStack {
            Text(text)
                .padding()
                .background(ChipBackgroundView(fillColor: chipFillColor()))

            Text(text)
                .padding()
                .background(ChipBackgroundView())

        }.foregroundColor(color)
            .font(Font.largeTitle.bold())
        
    }
    
}

private extension TextChipView {
    func chipFillColor() -> Color {
        #if os(macOS) || os(iOS)
        return .tertiarySystemBackground
        #else
        return .systemGray
        #endif
    }
}
struct TextChip_Previews: PreviewProvider {
    static let text = "The quick brown fox jumps over the lazy dog."
    
    static var previews: some View {
        Group {
            TextChipView(text: text, color: .quaternaryLabel)
            
            TextChipView(text: text, color: .quaternaryLabel)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
        
    }
}

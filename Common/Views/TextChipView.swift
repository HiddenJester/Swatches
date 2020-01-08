//
//  TextChip.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that takes a string and a color and draws the text in the specified color. First it is drawn over a `ChipBackgroundView` with a neutral color, then
/// it is drawn over a `ChipBackgroundView` with a checkerboard. The problem is that many of the label colors in dark mode because a white color with
/// very low alpha, which is almost invisible against the checkerboard. The first view makes sure you can see it, while the checkerboard allows seeing
/// translucency.
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
                .background(checkerboardBackground())

        }.foregroundColor(color)
            .font(textFont())
            .multilineTextAlignment(.center)

    }
    
}

private extension TextChipView {
    /// On platforms that support it, we want to use `.tertiarySystemBackground`. But only iOS and Mac(Catalyst) support that, while we still have
    /// text on tvOS. So on that platform just use `.systemGray`.
    func chipFillColor() -> Color {
        guard color != .clear else {
            return .clear
        }

        #if targetEnvironment(macCatalyst) || os(iOS)
        return .tertiarySystemBackground
        #else
        return .systemGray
        #endif
    }
    
    /// We only want to use a checkerboard for the second view if the color passed in wasn't `.clear`. But that means that we either want to use
    /// `Color.clear` for the background *OR* create the normal `ChipBackgroundView`. This helper function just type-erases that into something
    /// that can be passed into `.background()` regardless.
    func checkerboardBackground() -> some View {
        Group {
            if color == .clear {
                Color.clear
                
            } else {
                ChipBackgroundView()
                
            }
        }
    }
    
    /// tvOS looks better with a smaller font for the text chips, so this function returns the proper font for the platform.
    /// - Returns: on tvOS this is `Font.headline`. On other platforms this is `Font.largeTitle.bold()`
    func textFont() -> Font {
        #if os(tvOS)
        return Font.headline
        #else
        return Font.largeTitle.bold()
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
            
            TextChipView(text: text, color: .clear)
        }
        
    }
}

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

    /// The color name to add to the accessibility label. If this is `nil` then the whole view is hidden from accessibility.
    let colorName: String?

    var body: some View {
        VStack(spacing:10) {
            textSampleView { ChipBackgroundView(fillColor: chipFillColor()) }

            textSampleView { checkerboardBackground() }
        }
        .accessibilityElement(children: .ignore)
        .add(textColorAccessibilityLabelString: colorName)
    }
}

private extension TextChipView {
    /// Creates a textSampleView that displayes the text, forces a multiline sizing over truncation, draws the provided background, and draws a rounded
    /// outline around the entire sample.
    /// - Parameter background: A `ViewBuilder` that returns a single `ChipBackgroundView` to use as the background.
    /// - Returns: The sample view with the provided background.
    func textSampleView(@ViewBuilder background: @escaping () -> ChipBackgroundView) -> some View {
        Text(text)
            .foregroundColor(color)
            .font(textFont())
            .multilineTextAlignment(.center)
            .background(background())
            .overlay(RoundedRectangle(cornerRadius: 5.0)
                        .inset(by: 1)
                        .stroke(strokeColor(), lineWidth: 2)
            )
            .fixedSize(horizontal: false, vertical: true) // Force multi-line over truncation.
    }

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
    func checkerboardBackground() -> ChipBackgroundView{
        if color == .clear {
            return ChipBackgroundView(fillColor: .clear)
        } else {
            return ChipBackgroundView()
        }
    }
    
    /// tvOS looks better with a smaller font for the text chips, so this function returns the proper font for the platform.
    /// - Returns: the proper font to use for the text chips themselves.
    func textFont() -> Font {
        #if os(tvOS)
        return .headline
        #else
        return .title
        #endif
    }

    /// Determine the proper color to use for the outline.
    /// - Returns: The color to pass when stroking the outline.
    func strokeColor() -> Color {
        if color == .clear {
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

private extension View {
    /// Takes an optional `String`. If a string is provided then the accessbility label is set to "<String> Color". If `nil` is passed then
    /// the returned view is hidden from Accessibility. (The intention is to use this when drawing an entirely blank view that shouldn't have any interactions.
    /// - Parameter colorAccessibilityLabelString: A `String?` that if provided, is used to build the view's accessibility label.
    /// - Returns: Either the view with the specified accessibility label, or the view hidden from accessbility.
    func add(textColorAccessibilityLabelString: String?) -> some View {
        if let label = textColorAccessibilityLabelString {
            return self.accessibility(labelString: "Sample Text in \(label) Color")
        } else {
            return self.accessibilityHide(hideStatus: true)
        }
    }
}

struct TextChip_Previews: PreviewProvider {
    static let text = "The quick brown fox jumps over the lazy dog."
    
    static var previews: some View {
        Group {
            TextChipView(text: text, color: .quaternaryLabel, colorName: "Quaternary Label")
            
            TextChipView(text: text, color: .quaternaryLabel, colorName: "Quaternary Label")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
            
            TextChipView(text: text, color: .clear, colorName: nil)
                .previewDisplayName("Clear color")
        }
        .previewLayout(PreviewLayout.sizeThatFits)
        
    }
}

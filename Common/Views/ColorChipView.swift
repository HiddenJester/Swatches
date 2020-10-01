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

    /// The name of the color, which will be used in the accessbility label.
    let name: String?

    /// Set to true to draw the checkerboard background (and the outline).
    var drawBackground = true

    // Arbitrary values designed to not take up a ridiculous amount of space.
    #if os(tvOS)
    let minLength = CGFloat(100)
    let maxLength = CGFloat(300)
    #elseif os(watchOS)
    let minLength = CGFloat(30)
    let maxLength = CGFloat(150)
    #else
    let minLength = CGFloat(50)
    let maxLength = CGFloat(100)
    #endif
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .add(colorAccessibilityLabelString: name)
            .foregroundColor(color)
            .background(ChipBackgroundView(fillColor: drawBackground ? nil : .clear))
            .overlay(RoundedRectangle(cornerRadius: 5.0)
                        .inset(by: 1)
                        .stroke(strokeColor(), lineWidth: 2)
            )
            .frame(minWidth: minLength, maxWidth: maxLength, minHeight: minLength, maxHeight: maxLength)
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

private extension View {
    /// Takes an optional `String`. If a string is provided then the accessbility label is set to "<String> Color". If `nil` is passed then
    /// the returned view is hidden from Accessibility. (The intention is to use this when drawing an entirely blank view that shouldn't have any interactions.
    /// - Parameter colorAccessibilityLabelString: A `String?` that if provided, is used to build the view's accessibility label.
    /// - Returns: Either the view with the specified accessibility label, or the view hidden from accessbility.
    func add(colorAccessibilityLabelString: String?) -> some View {
        if let label = colorAccessibilityLabelString {
            return self.accessibility(labelString: "\(label) Color")
        } else {
            return self.accessibility(hidden: true)
        }
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorChipView(color: .blue, name: "Blue")
            ColorChipView(color: .clear, name: "Clear")
            ColorChipView(color: .clear, name: nil, drawBackground: false)
        }
        .background(Color.green)
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

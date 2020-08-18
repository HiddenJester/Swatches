//
//  Swatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A specialized view that draws the generic framing for a swatch. A background and outline can be drawn or omitted (both are drawn in adaptive colors). A
/// `SwatchLabel` will be provided and drawn with the provided string. The background (and outline) are drawn with rounded corners.
struct SwatchView<Content>: View where Content: View {
    /// Should we draw the background and outline?
    let drawBackgroundAndOutline: Bool
    
    /// The text to draw in the `SwatchLabel`
    let label: String
    
    /// The content of ths swatch, passed in as a `@ViewBuilder`.
    private let content: Content

    /// The Supported OSes for this swatch to draw.
    let supportedOS: SupportedOSOptions
    
    /// The corner radius to use on the background and outline.
    private let cornerRadius = CGFloat(5.0)

    /// If a width greater than zero is provided then the `SwatchView` will render with that width in the frame. If nil or 0 are passed in then the view
    /// renders without a specified frame.
    let width: CGFloat?

    var body: some View {
        VStack() {
            HStack() {
                content
                
                if drawBackgroundAndOutline {
                    SupportedOSTagView(value: supportedOS)
                }
            }
            
            SwatchLabelView(text: label)
        }
        .padding()
        .background(backgroundColor())
        .cornerRadius(cornerRadius)
        .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(drawBackgroundAndOutline ? Color.primary : Color.clear, lineWidth: 2))
        .padding(1) // Give us a point around the stroke so we can see it.
        .frame(width: width)
    }
    
    /// Create a new Swatch
    /// - Parameters:
    ///   - drawBackgroundAndOutline: A Bool that controls both drawing a background and an outline.
    ///   - label: The text to display as the label for for the Swatch
    ///   - supportedOS: The SupportedOSOptions to draw.
    ///   - content: The actual content of the Swatch. This is a `@ViewBuilder` closure, so practically any SwiftUI view can be placed in a swatch.
    init(drawBackgroundAndOutline: Bool,
         label: String,
         supportedOS: SupportedOSOptions,
         width: CGFloat? = nil,
         @ViewBuilder _ content: @escaping () -> Content) {
        self.drawBackgroundAndOutline = drawBackgroundAndOutline
        self.label = label
        self.supportedOS = supportedOS
        if let width = width, width > 0 {
            self.width = width
        } else {
            self.width = nil
        }
        self.content = content()
    }
}

private extension SwatchView {
    /// Returns a `Color` suitable for the swatch background.
    /// - Returns: A `Color` for the background. For iOS and macOS this will be `systemFill`. watchOS and tvOS don't support that fill so this
    ///     returns `gray` on `watchOS` and `secondary` on tvOS.
    func backgroundColor() -> Color {
        guard drawBackgroundAndOutline else {
            return .clear
        }
        
        #if os(watchOS)
        return .fixedDarkGray
        #elseif os(tvOS)
        return .secondary
        #else
        return .systemFill
        #endif
    }
}

struct Swatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwatchView(drawBackgroundAndOutline: true,
                       label: "Super Duper Wordy Ass Background Test",
                       supportedOS: .iOSAndMac,
                       width: 300) {
                ColorChipView(color: .blue)
            }
            
            SwatchView(drawBackgroundAndOutline: false, label: "Clear Test", supportedOS: .all) {
                ColorChipView(color: .clear)
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

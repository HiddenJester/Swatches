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

    /// If a width is provided than the frame is locked to that value. A width of 0 or less is discarded in `init`.
    let width: CGFloat?

    var body: some View {
        VStack() {
            content

            SupportedOSTagView(value: supportedOS, opacity: drawBackgroundAndOutline ? 1 : 0)

            SwatchLabelView(text: label)
        }
        .padding(cornerRadius)
        .frame(minWidth: width)
        .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .inset(by: 1)
                    .stroke(drawBackgroundAndOutline ? Color.primary : Color.clear, lineWidth: 2))
        .background(backgroundColor())
        .cornerRadius(cornerRadius)
    }
    
    /// Create a new Swatch
    /// - Parameters:
    ///   - drawBackgroundAndOutline: A Bool that controls both drawing a background and an outline.
    ///   - label: The text to display as the label for for the Swatch
    ///   - supportedOS: The SupportedOSOptions to draw.
    ///   - width: pass a non-zero `CGFloat` here to fix the width of the view. Passing 0 or nil will let the view dynamically set the width.
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
    static let width: CGFloat = 150

    static var previews: some View {
        Group {
            SwatchView(drawBackgroundAndOutline: true,
                       label: "Here's a Little Story I'd Like to Tell, About Three Bad Brothers That You Know So Well.",
                       supportedOS: .iOSAndMac,
                       width: width) {
                ColorChipView(color: .blue)
            }
            
            SwatchView(drawBackgroundAndOutline: true, label: "Clear Test", supportedOS: .all, width: width) {
                ColorChipView(color: .clear)
            }

            #if os(macOS) || os(iOS)
            SwatchView(drawBackgroundAndOutline: true, label: "Text Test", supportedOS: .all) {
                TextChipView(text: "Here's some longer text", color: .black)
            }
            #endif
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

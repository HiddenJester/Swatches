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
    let drawBackground: Bool
    
    /// The text to draw in the `SwatchLabel`
    let label: String
    
    /// The content of ths swatch, passed in as a `@ViewBuilder`.
    private let content: Content

    /// The Supported OSes for this swatch to draw.
    let supportedOS: SupportedOSOptions
    
    /// The corner radius to use on the background and outline.
    private let cornerRadius = CGFloat(20.0)

    var body: some View {
        VStack() {
            HStack() {
                content.padding([.leading, .top])
                
                if drawBackground {
                    SupportedOSTagView( value: supportedOS)
                    
                }
            }
            
            SwatchLabelView(text: label)
                .padding([.horizontal, .bottom], 3)
            
        }.background(backgroundColor())
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(drawBackground ? Color.primary : Color.clear, lineWidth: 2))
            .padding(1) // Give us at least a point around the stroke so we can see it.
    }
    
    /// Create a new Swatch
    /// - Parameters:
    ///   - drawBackground: A Bool that controls both drawing a background and an outline.
    ///   - label: The text to display as the label for for the Swatch
    ///   - supportedOS: The SupportedOSOptions to draw.
    ///   - content: The actual content of the Swatch. This is a `@ViewBuilder` closure, so practically any SwiftUI view can be placed in a swatch.
    init(drawBackground: Bool,
         label: String,
         supportedOS: SupportedOSOptions,
         @ViewBuilder _ content: @escaping () -> Content) {
        self.drawBackground = drawBackground
        self.label = label
        self.supportedOS = supportedOS
        self.content = content()
    }
}

private extension SwatchView {
    /// Returns a `Color` suitable for the swatch background.
    /// - Returns: A `Color` for the background. For iOS and macOS this will be `systemFill`. watchOS and tvOS don't support that fill so this
    ///     returns `gray` on `watchOS` and `secondary` on tvOS.
    func backgroundColor() -> Color {
        guard drawBackground else {
            return .clear
        }
        
        #if os(watchOS)
        return .gray
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
            SwatchView(drawBackground: true, label: "Wordy Ass Background Test", supportedOS: .iOSAndMac) {
                ColorChipView(color: .blue)
            }
            
            SwatchView(drawBackground: false, label: "Clear Test", supportedOS: .all) {
                ColorChipView(color: .clear)
            }
        }
    }
}

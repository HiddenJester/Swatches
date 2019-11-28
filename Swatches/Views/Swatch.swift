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
struct Swatch<Content>: View where Content: View {
    /// Should we draw the background and outline?
    let drawBackground: Bool
    
    /// The text to draw in the `SwatchLabel`
    let label: String
    
    let content: Content

    private let cornerRadius = CGFloat(20.0)

    /// Padding edges for the content. It's only three edges because the label pads the bottom edge of the content.
    private let contentPadding: Edge.Set = [.top, .leading, .trailing]

    var body: some View {
        VStack() {
            content
                .padding(contentPadding)
            
            SwatchLabel(text: label)
            
        }.background(drawBackground ? Color.systemFill : Color.clear)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(drawBackground ? Color.primary : Color.clear, lineWidth: 2))
    }
    
    /// Create a new Swatch
    /// - Parameters:
    ///   - drawBackground: A Bool that controls both drawing a background and an outline.
    ///   - label: The text to display as the label for for the Swatch
    ///   - content: The actual content of the Swatch. This is a `@ViewBuilder` closure, so practically any SwiftUI view can be placed in a swatch.
    init(drawBackground: Bool, label: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.drawBackground = drawBackground
        self.label = label
        self.content = content()
    }
}

struct Swatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Swatch(drawBackground: true, label: "Background Test") {
                Text("Testing").padding()
            }
            
        Swatch(drawBackground: false, label: "Clear Test") {
                Text("Clear").padding()
            }
        }
    }
}

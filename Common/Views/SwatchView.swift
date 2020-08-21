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

    /// If a size not equal to `.zero` is provided then the `SwatchView` will render with that size in the frame. If nil or 0 are passed in then the view
    /// renders without a specified frame.
    let size: CGSize?

    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                content

                SupportedOSTagView(value: supportedOS, opacity: drawBackgroundAndOutline ? 1 : 0)
                /// Setting a layoutPriority here breaks the macOS version. 🤷‍♂️ The specific problem was fixed
                /// by altering the content of `SupportedOSTagView`.
            }
            .padding(.horizontal)

            Spacer()

            SwatchLabelView(text: label)
                .padding(.horizontal, 2) /// *Tiny* bit of horizontal padding so the text doesn't drive up against the border.
        }
        .padding(.vertical)
        .frame(width: size?.width, height: size?.height)
        .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .inset(by: 1)
                    .stroke(drawBackgroundAndOutline ? Color.primary : Color.clear, lineWidth: 2)
        )
        .background(backgroundColor())
        .cornerRadius(cornerRadius)
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
         size: CGSize? = nil,
         @ViewBuilder _ content: @escaping () -> Content) {
        self.drawBackgroundAndOutline = drawBackgroundAndOutline
        self.label = label
        self.supportedOS = supportedOS
        if let size = size, size != .zero {
            self.size = size
        } else {
            self.size = nil
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
    static let size = CGSize(width: 200, height: 100)

    static var previews: some View {
        Group {
            SwatchView(drawBackgroundAndOutline: true,
                       label: "Super Duper Wordy Ass Label Test",
                       supportedOS: .iOSAndMac,
                       size: nil) {
                ColorChipView(color: .blue)
            }
            
            SwatchView(drawBackgroundAndOutline: true, label: "Clear Test", supportedOS: .all, size: size) {
                ColorChipView(color: .clear)
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

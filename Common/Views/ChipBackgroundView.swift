//
//  ChipBackground.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that optionally draws a rounded rectangle of either A ) a specified color; or B) a tiled  checkerboard pattern suitable for displaying behind
/// translucent content. If anything is drawn other than `.clear` then a black outline is drawn as well.
struct ChipBackgroundView: View {
    /// The color to fill the background with. If left at the default value of `nil` it will draw a checkerboard pattern instead. If it is set to `.clear` then
    /// there is no stroke outline drawn. If it is `nil` or any other color then then the outline is drawn.
    /// - Note: The stroke outline is drawn *unless the color is specifically `.clear`*. `.fixedClear` will still draw the outline, as will any other color
    ///     with an alpha component of zero. AFAICT, there's no way to extract an alpha value from a `Color` so you can't check the transparency.
    var fillColor: Color? = nil
    
    /// When the checkerboard is drawn, this is the `cornerRadius` used by the image.
    private let cornerRadius = CGFloat(5)

    var body: some View {
        backgroundView()
    }
}

private extension ChipBackgroundView {
    /// Helper function that checks `drawCheckerboard` and returns a single view. This makes appying the `overlay` modifier for the outline cleaner.
    /// - Returns: If `drawCheckerboard` is true it returns a tiled checkerboard `Image` with rounded corners. If it is false then it returns just
    ///     `Color.clear`.
    func backgroundView() -> some View {
        let image = Image(decorative: "Checkerboard")
            .resizable(resizingMode: .tile)
            .cornerRadius(cornerRadius)

        /// Can't use if let here, the test is *specifically* if fillColor == Color.clear
        if let fillColor = fillColor {
            return image
                .opacity(0)
                .background(fillColor
                                .cornerRadius(cornerRadius)
                )
        } else {
            return image
                .opacity(1)
                .background(Color.clear
                                .cornerRadius(cornerRadius)
                )
        }
    }
}

struct ChipBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChipBackgroundView()

            #if os(iOS)
            ChipBackgroundView(fillColor: .tertiarySystemGroupedBackground)
            #endif
            ChipBackgroundView(fillColor: .gray)

            ChipBackgroundView(fillColor: .clear)

            ChipBackgroundView(fillColor: .blue)
                .environment(\.colorScheme, .dark)
        }
        .background(Color.green)
        .previewLayout(PreviewLayout.fixed(width: 50, height: 50))
    }
}

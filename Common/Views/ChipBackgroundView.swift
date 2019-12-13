//
//  ChipBackground.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that optionally draws either A ) nothing (well. It draws `Color.clear`) or B ) draws a tiled checkerboard pattern suitable for displaying behind
/// translucent content. If the checkerboard is drawn it is outlined in black and it has rounded corners of the specified radius.
struct ChipBackgroundView: View {
    /// The flag that determines whether the checkerboard & outline should be drawn.
    let drawCheckerboard: Bool

    /// When the checkerboard is drawn, this is the `cornerRadius` used by the image.
    let cornerRadius: CGFloat

    var body: some View {
        view()
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(drawCheckerboard ? Color.black : Color.clear, lineWidth: 2))
    }
}

private extension ChipBackgroundView {
    /// Helper function that checks `drawCheckerboard` and returns a single view. This makes appying the `overlay` modifier for the outline cleaner.
    /// - Returns: If `drawCheckerboard` is true it returns a tiled checkerboard `Image` with rounded corners. If it is false then it returns just
    ///     `Color.clear`.
    func view() -> some View {
        Group {
            if drawCheckerboard {
                Image("Checkerboard")
                    .resizable(resizingMode: .tile)
                    .cornerRadius(cornerRadius)
            } else {
                Color.clear
            }
        }
    }
}

struct ChipBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChipBackgroundView(drawCheckerboard: true, cornerRadius: 20.0)
            
            ChipBackgroundView(drawCheckerboard: false, cornerRadius: 20.0)
        }
    }
}

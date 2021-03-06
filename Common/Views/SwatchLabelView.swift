//
//  SwatchLabel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that displays a text in the `.label` Color with truncation set for the middle
/// - Parameter text: The text to display in the label.
struct SwatchLabelView: View {
    /// The text to display.
    let text: String

    var body: some View {
        Text(text)
            .accessibility(labelString: "\(text) Color")
            .font(.headline)
            .foregroundColor(color())
            .truncationMode(.middle)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true) // Force multiline, not truncation.
    }
}

private extension SwatchLabelView {
    /// Provides a `Color` suitable for the foreground color of a `SwatchLabel`.
    /// - Returns: A `Color` that can be used for the foreground color on the platform. watchOS doesn't support `.label` so on that plaform it
    ///     simply returns `.white`. On platforms that support `.label` that color is returned.
    func color() -> Color {
        #if os(watchOS)
        return .white
        #else
        return .label
        #endif
    }
}

struct SwatchLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwatchLabelView(text: "Testing Label")

            SwatchLabelView(text: "Super Wordy Ass Multiline Label That is Really Quite Unreasonable")

        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

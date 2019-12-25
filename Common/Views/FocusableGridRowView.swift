//
//  FocusableGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-06.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct FocusableGridRowView<Content>: View where Content: View {
    /// Content passed in to render.
    private let content: Content

    /// When the content has focus, scale it up by this value in order to see where the focus is.
    @State private var scale = CGFloat(1)
    
    var body: some View {
        platformSpecificView()

    }

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content()
    }
}

private extension FocusableGridRowView {
    /// Create the platform-specific view. Although everything but iOS *supports* focusable, we only want to use it on tvOS. On all other platforms this
    /// just returns `self.content`. On tvOS `self.content` is centered in a `HStack`, then padded and scaled up by `self.scale`. A
    /// `focusable` modifier is added to adjust `self.scale`.
    /// - Returns: `self.content`. If needed by the platform it is wrapped in the needed modifiers to implement focusable support & display.
    func platformSpecificView() -> some View {
        #if os(tvOS)
        return HStack {
            Spacer()
            
            self.content
                .padding()
                .scaleEffect(self.scale)
                .focusable(true) { focus in withAnimation { self.scale = focus ? 1.1 : 1 } }
            
            Spacer()
        }
        #else
        return content
        #endif
    }
}
struct FocusableGridRow_Previews: PreviewProvider {
    static var models = ColorModel.swiftUIColors()

    static var previews: some View {
        FocusableGridRowView() {
            HStack {
                ColorSwatchView(model: models[0])

                ColorSwatchView(model: models[1])
            }
        }
    }
}

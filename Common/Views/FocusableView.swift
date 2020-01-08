//
//  FocusableGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-06.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A platform-independent view that supports tvOS's concept of focus. On any platform other than tvOS this just renders the provided content. On tvOS a
/// `focusScale` can be passed to use when the content has focus and the view will animate to/from that scale when it gains/loses focus. If no value is passed
/// in then a default scale of `1.15` will be applied. Note that other platforms will accept a `focusScale`, but do not use it for anything.
/// - Note: iOS does not support the `focusable()` modifier in iOS 13 (contrary to what was demonstrated at WWDC) & we don't need the animation
///     on macOS or watchOS; so the only platform that actually *does* anything in this view is tvOS.
/// - Note: SwiftUI on tvOS is still seems a bit janky. It can't separate the "focus" from the "unfocus" animation the way UIKit can. Also, this doesn't seem
///     interruptible, reversible, or smooth AND it uses a LOT of CPU. 🤷‍♂️ I think the answer is that anything that needs focus in tvOS needs to be written in
///     UIKit so it can access the deeper animation controls there. But honestly, for Swatches I don't care enough to do that, it's just a simple development utility.
///     The ability to scroll through views is all that we need here, and see where the focus is.
struct FocusableView<Content>: View where Content: View {
    /// The amount to scale the view when it has focus
    let focusScale: CGFloat
    
    /// Content passed in to render.
    private let content: Content
    
    /// When the content has focus, scale it up by this value in order to see where the focus is.
    @State private var scale = CGFloat(1)
    
    var body: some View {
        platformSpecificView()
        
    }
    
    /// Create a new FocusableView struct.
    /// - Parameters:
    ///   - focusScale: The scale to use when `content` has focus. Defaults to `1.15`. `content` will scale to/from this value when it gains/loses
    ///     focus.
    ///   - content: A `@ViewBuilder` that renders the actual content.
    init(focusScale: CGFloat = 1.15, @ViewBuilder _ content: @escaping () -> Content) {
        self.focusScale = focusScale
        self.content = content()
    }
}

private extension FocusableView {
    /// Create the platform-specific view. Although everything but iOS *supports* focusable, we only want to use it on tvOS. On all other platforms this
    /// just returns `self.content`. On tvOS `self.content` is centered in a `HStack`, then padded and scaled up by `self.scale`. A
    /// `focusable` modifier is added to adjust `self.scale`.
    /// - Returns: `self.content`. If needed by the platform it is wrapped in the needed modifiers to implement focusable support & display.
    func platformSpecificView() -> some View {
        #if os(tvOS)
        return self.content
            .scaleEffect(self.scale)
            .padding()
            .focusable() { focus in self.scale = focus ? self.focusScale : 1 }
            .animation(.default, value: self.scale)

        #else
        return content
        
        #endif
    }
}

struct FocusableView_Previews: PreviewProvider {
    static var models = ColorModel.swiftUIColors()
    
    static var previews: some View {
        HStack {
            FocusableView() {
                ColorSwatchView(model: models[0], maxWidth: 350)
                
            }
            
            FocusableView() {
                ColorSwatchView(model: models[1], maxWidth: 350)
                
            }
            
        }
    }
}

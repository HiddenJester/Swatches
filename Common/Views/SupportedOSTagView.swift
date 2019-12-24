//
//  SupportedOSTagView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-17.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SupportedOSTagView: View {
    /// The value to use to display the tags.
    let value: SupportedOSOptions
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            tagView(forOS: .iOS)

            tagView(forOS: .macOS)
            
            tagView(forOS: .tvOS)
            
            tagView(forOS: .watchOS)

        }.layoutPriority(1)
    }
}

private extension SupportedOSTagView {
    /// Returns a tag for the specified OS. The proper label will be looked up (see `textView()`), and either a green checkmark or a red X will be drawn.
    /// - Parameter forOS: The OS to check. Note that if you pass a set in for this (such as `iOSAndMac`) you will get a tag for the first OS that matches.
    ///     Since this function is private and the calls are hard-coded this is OK, just don't pass anything silly in.
    func tagView(forOS: SupportedOSOptions) -> some View {
        #if targetEnvironment(macCatalyst)
        // On the Mac use a larger font …
        let font = Font.subheadline
        #elseif os(watchOS)
        // And on the watch use a *smaller* font …
        let font = Font.footnote
        #else
        // But for iOS & tvOS use caption.
        let font = Font.caption
        #endif
        
        return HStack(spacing: 0) {
            textView(forOS: forOS)
            
            imageView(forOS: forOS)
        }.font(font)
    }
    
    /// Returns an erased `Text` with the proper label for the provided OS.
    /// - Parameter forOS: The OS to check. See the note above on `tagView` for a discussion about sending sets to this parameter.
    func textView(forOS: SupportedOSOptions) -> some View {
        let label: String
        
        switch forOS {
        case let x where x.contains(.iOS):
            label = "iOS"
            
        case let x where x.contains(.macOS):
            label = "macOS"
            
        case let x where x.contains(.tvOS):
            label = "tvOS"
            
        case let x where x.contains(.watchOS):
            label = "watchOS"
            
        default:
            label = "?"
        }
        
        return Text("\(label):")
            .lineLimit(1)
    }
    
    /// Returns an erased `Image` with a SFSymbol. If the provided OS is listed in `value` then a green checkmark is returned, otherwise a red X will
    /// be returned.
    /// - Parameter forOS: The OS to check. Honestly I'm  not 💯 what happens if you pass a set in here. Don't, that doesn't make sense.
    func imageView(forOS: SupportedOSOptions) -> some View {
        if value.contains(forOS) {
            return Image(systemName: "checkmark")
                .foregroundColor(.green)
        } else {
            return Image(systemName: "xmark")
                .foregroundColor(.red)
        }
    }
}

struct SupportedOSTagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SupportedOSTagView(value: .all)
            
            SupportedOSTagView(value: .iOSAndMac)
        }
    }
}

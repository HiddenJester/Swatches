//
//  SupportedOSTagView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-17.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SupportedOSTagFormatKey: EnvironmentKey {
    static var defaultValue: SupportedOSTagView.TagFormat = .twoColumn
}

extension EnvironmentValues {
    var supportedOSTagFormat: SupportedOSTagView.TagFormat {
        get { self[SupportedOSTagFormatKey.self] }
        set { self[SupportedOSTagFormatKey.self] = newValue }
    }
}

/// A view that displays a `SupportedOSOptions` value. The name of the OS is listed, with a green check if the OS is supported, or a red X if it is not.
/// This needs to have a `SupportedOSTagFormatKey` `EnvironmentValue` set to control whether it should display in the 2 or 4 column format.
struct SupportedOSTagView: View {
    /// An enum to control the layout of the tag view.
    enum TagFormat {
        case twoColumn      /// Display the OSes as a 2x2 grid
        case fourColumn     /// Display the OSes as a 1x4 single row.
    }

    /// The value to use to display the tags.
    let value: SupportedOSOptions

    /// The opacity to draw the tag at.
    let opacity: Double

    /// It's possible to override the environment-provided format. This is primarily used to force 4-column when calculating layout options. If this
    /// value is provided the environment value is ignored.
    let overrideFormat: TagFormat?

    /// If `overrideFormat` isn't provided then this enivronment value will determine the layout to use. The idea here is that the grid selects the proper
    /// format for the grid sizes provided.
    @Environment(\.supportedOSTagFormat) var environmentFormat

    var body: some View {
        Group {
            switch overrideFormat ?? environmentFormat {
            case .twoColumn:
                twoColumnView()

            case .fourColumn:
                fourColumnView()
            }
        }
        .opacity(opacity)
    }

    /// Create a new `SupportedOSTagView`. Note that this allows overriding the environment-provided `TagFormat`
    /// - Note: This view requires that a `TagFormat` value is provided as an `EnvironmentValue` for the path `\.supportedOSTagFormat`.
    /// - Parameters:
    ///   - value: A `SupportedOSOptions` object to render.
    ///   - opacity: An opacity to render at.
    ///   - overrideTagFormat: Defaults to 'nil'. If a `TagFormat` is provided the view will render in that format, regardless of the environment
    ///         value.
    public init(value: SupportedOSOptions, opacity: Double, overrideTagFormat: TagFormat? = nil) {
        self.value = value
        self.opacity = opacity
        self.overrideFormat = overrideTagFormat
    }

}

private extension SupportedOSTagView {
    /// Creates the 2x2 grid view of tags
    /// - Returns: The view called for by `TagFormat.twoColumn`.
    func twoColumnView() -> some View {
        HStack {
            VStack(alignment: .trailing, spacing: 0) {
                tagView(forOS: .iOS)

                tagView(forOS: .macOS)
            }

            VStack(alignment: .trailing, spacing: 0) {
                tagView(forOS: .watchOS)

                tagView(forOS: .tvOS)
            }
        }
    }

    /// Creates the 1x4 grid view of tags
    /// - Returns: The view called for by `TagFormat.fourColumn`.
    func fourColumnView() -> some View {
        HStack {
            tagView(forOS: .iOS)

            tagView(forOS: .macOS)

            tagView(forOS: .watchOS)

            tagView(forOS: .tvOS)
        }
    }

    /// Returns a tag for the specified OS. The proper label will be looked up (see `textView()`), and either a green checkmark or a red X will be drawn.
    /// - Parameter forOS: The OS to check. Note that if you pass a set in for this (such as `iOSAndMac`) you will get a tag for the first OS that matches.
    ///     Since this function is private and the calls are hard-coded this is OK, just don't pass anything silly in.
    func tagView(forOS: SupportedOSOptions) -> some View {
        let font: Font
        
        #if targetEnvironment(macCatalyst)
        // On the Mac use a larger font …
        font = Font.subheadline
        #else
        font = Font.caption
        #endif
        
        return HStack(spacing: 0) {
            textView(forOS: forOS)
            
            imageView(forOS: forOS)
        }
        .font(font)
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
        
        return Text("\(label): ")
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
            SupportedOSTagView(value: .all, opacity: 1)

            SupportedOSTagView(value: .iOSAndMac, opacity: 1)
                .environment(\.supportedOSTagFormat, .fourColumn)

            SupportedOSTagView(value: .all, opacity: 0)
                .previewDisplayName("Opacity: 0")
        }
        .environment(\.supportedOSTagFormat, .twoColumn)
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

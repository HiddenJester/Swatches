//
//  HostingController.swift
//  Swatches-watchOS WatchKit Extension
//
//  Created by Timothy Sanders on 2019-12-03.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

/// A very thin shim to get around `WKHostingController` needing the type of the view. I mean, the type is known, but it's super-ugly & brittle that's the
/// whole point of the `some View` construction in the first place. The alternative is to use `AnyView`, but this looks less hacky.
struct WatchMainView: View {
    var body: some View {
        VStack {
            Text("Color Sets")
                .font(.title)

            List {
                NavigationLink("SwiftUI", destination: colorListView(models: ColorModel.swiftUIColors()))
                NavigationLink("Fixed", destination: colorListView(models: ColorModel.fixedColors()))
            }
        }
    }
}

private extension WatchMainView {
    /// Creates the watch-specific scrollable view of color models. Since none of the text colors are supported on the watch we don't need to through
    /// the indirection of templating for `GridModel` and can directly use `ColorModel` here.
    /// - Parameter models: The `ColorModel` objects to render
    /// - Returns: A simple `ScrollView` showing all of the `ColorSwatchViews` for the provided models.
    func colorListView(models: [ColorModel]) -> some View {
        ScrollView {
            ForEach(models, id: \.self) { (model) in
                ColorSwatchView(model: model, width: nil)
            }
        }
    }
}

class HostingController: WKHostingController<WatchMainView> {
    override var body: WatchMainView {
        WatchMainView()
    }
}


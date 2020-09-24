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

class HostingController: WKHostingController<AnyView> {
    override var body: AnyView {
        AnyView(List {
            NavigationLink("SwiftUI", destination: ColorListView(models: ColorModel.swiftUIColors()))
            NavigationLink("Fixed", destination: ColorListView(models: ColorModel.fixedColors()))
        })
    }

    func ColorListView(models: [ColorModel]) -> some View {
        ScrollView {
            ForEach(models, id: \.self) { (model) in
                ColorSwatchView(model: model, width: nil)
            }
        }
    }
}


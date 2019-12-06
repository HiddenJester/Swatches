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

class HostingController: WKHostingController<MainView> {
    override var body: MainView {
        // Create the GridModels we want to render.
        let grids = [
            GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors()),
            GridModel(name: "Fixed", models: ColorModel.fixedColors()),
        ]
        // Create the `MainView` that renders the grids.
        return MainView(gridModels: grids)
    }
}

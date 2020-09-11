//
//  SceneDelegate.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Create the GridModels we want to render.
        let grids = [
            GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors()),
            GridModel(name: "Adaptable", models: ColorModel.adaptableColors()),
            GridModel(name: "Fixed", models: ColorModel.fixedColors()),
            GridModel(name: "Text", models: TextModel.textModels()),
        ]
        // Create the `MainView` that renders the grids.
        let contentView = MainView(gridModels: grids)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


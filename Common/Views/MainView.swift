//
//  MainList.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// This view is the main view for the app. It displays a `GridHeader` at the top, hosts the needed bindings for that view and then displays the selected
/// grid below. It also sets the dark mode Bool to make the environment when it appears.
/// - Parameter gridModels: The grid models that can be displayed by this view.
struct MainView: View {
    /// Need to access the environment's color scheme in order to set the initial vlaue of `darkModeSelected`
    @Environment(\.colorScheme) var envScheme: ColorScheme

    /// These grid models can be displayed. The names will be displayed in the header.
    let gridModels: [GridModel]
    
    /// Storage for the selected Grid index.
    @State private var selectedGridIndex = 0
        
    /// Storage for the dark mode Bool.
    @State private var darkModeSelected = false
    
    var body: some View {
        VStack {
            GridHeaderView(darkModeSelected: $darkModeSelected,
                       gridIndex: $selectedGridIndex,
                       gridNames: gridModels.map { $0.name })
            
            gridView()

        }.background(backgroundColor()) // Need an adaptive background or dark mode looks bad.
            .onAppear { self.darkModeSelected = (self.envScheme == .dark) } // Copy the environment value.
            .colorScheme(darkModeSelected ? .dark : .light) // Set the color scheme to the toggle value.
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
    }
}

private extension MainView {
    /// Returns the properly typed grid for the selected grid model. This checks the type of SwatchModel stored in the selected grid model. Once it knows
    /// what type of grid to create it creates a FlowableContentGrid containing the proper `SwatchView` objects for the models.
    /// - Returns: A grid view containing the models for the selected grid. If there's some sort of error it returns a simple `Text` describing the error.
    func gridView() -> some View {
        let models = self.gridModels[selectedGridIndex].models
        let modelType = models.count > 0 ? type(of: models[0]) : nil
        let optimalColorWidth: CGFloat
        let colorColumnMax: Int
        let optimalTextWidth: CGFloat

        #if os(tvOS)
        optimalColorWidth = 400
        colorColumnMax = 6
        optimalTextWidth = 600
        #elseif targetEnvironment(macCatalyst)
        optimalColorWidth = 250
        colorColumnMax = 10
        optimalTextWidth = 500
        #else
        optimalColorWidth = 150
        colorColumnMax = 8
        optimalTextWidth = 500
        #endif

        return Group {
            if modelType == ColorModel.self {
                // Forced unwrap is fine here, we just checked the type above.
                FlowableContentGridView(models: models as! [ColorModel],
                                    optimalCellWidth: optimalColorWidth,
                                    maxColumns: colorColumnMax) { (model: ColorModel?) in
                                        ColorSwatchView(model: model, maxWidth: optimalColorWidth)
                }

            } else if modelType == TextModel.self {
                #if !os(watchOS)
                // Forced unwrap is fine here, we just checked the type above.
                TextSwatchGridView(models: models as! [TextModel], optimalTextWidth: optimalTextWidth)
                #else
                Text("Watch doesn't support TextGrid")
                #endif

            } else {
                Text("Missing Grid Type!")
                
            }

        }
    }
    
    /// Returns a `Color` suitable for the background color of the `MainView`.
    /// - Returns: A `Color` for the background. On iOS or macOS this will always be `.systemBackground`. watchOS doesn't support adaptive
    ///     colors, so on watchOS this is always `.black`. tvOS supports adaptive colors, but not the system background 🤷‍♂️, so it returns `.clear`.
    func backgroundColor() -> Color {
        #if os(watchOS)
        return .black
        #elseif os(tvOS)
        return .clear
        #else
        return .systemBackground
        #endif
    }
}

struct MainView_Previews: PreviewProvider {
    static let swiftUI = GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors())

    #if os(iOS) || os(tvOS)
    static let textView =  GridModel(name: "Text", models: TextModel.textModels())
    static let adaptable = GridModel(name: "Adaptable", models: ColorModel.adaptableColors())

    static var previews: some View {
        Group {
            MainView(gridModels: [textView, swiftUI])

            MainView(gridModels: [adaptable, textView])

            MainView(gridModels: [swiftUI, textView])
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
            
        }
    }
    #elseif os(watchOS)
    static var previews: some View {
        MainView(gridModels: [swiftUI])
        
    }
    #endif
}

//
//  MainList.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// This view is the main view for the app. It displays a `GridHeader` at the top, hosts the needed bindings for that view and then displays the selected
/// grid below. It also sets the dark mode Bool to match the environment when it appears.
/// - Parameter gridModels: The grid models that can be displayed by this view.
/// - Note: MainView *works* on tvOS but the UI requirements for tvOS needs a different design. So for tvOS look at the `TVMainView` struct.
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
        /// Convenience accessor to get at the selected grid's models.
        let models = self.gridModels[selectedGridIndex].models
        
        /// Determines what type of models are stored in `models`. Used to type the content of the grids.
        let modelType = models.count > 0 ? type(of: models[0]) : nil
        
        /// Platform dependent constant that is the ideal color swatch width.
        let optimalColorWidth: CGFloat
        
        /// Platform dependent constant that is the maximum number of columns we want in a color grid.
        let colorColumnMax: Int
        
        /// Platform dependent constant that is the ideal text swatch width.
        let optimalTextWidth: CGFloat

        // Set the platform constants. Note that *watchOS* shares the same constants as iOS. This is fine because
        // the watch is so narrow that it's going to constantly decide to have a single column display.
        #if os(tvOS) // Not currently in use, but these values make a decent view on tvOS.
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
                                        ColorSwatchView(model: model)
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

    #if os(iOS) || os(tvOS) // watchOS doesn't support text models or adaptable colours.
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
        .previewLayout(PreviewLayout.sizeThatFits)
    }
    #elseif os(watchOS)
    static var previews: some View {
        MainView(gridModels: [swiftUI])
            .previewLayout(PreviewLayout.sizeThatFits)
    }
    #endif
}

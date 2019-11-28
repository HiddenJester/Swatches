//
//  MainList.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Combine

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
            GridHeader(darkModeSelected: $darkModeSelected,
                       gridIndex: $selectedGridIndex,
                       gridNames: gridModels.map { $0.name })
            
            gridView()
            
        }.background(Color.systemBackground) // Need an adaptive background or dark mode looks bad.
            .onAppear { self.darkModeSelected = (self.envScheme == .dark) } // Copy the environment value.
            .colorScheme(darkModeSelected ? .dark : .light) // Set the color scheme to the toggle value.
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
    }
    
    
}

private extension MainView {
    /// Returns the properly typed grid for the selected grid model. this checks the type of SwatchModel stored in the selected grid model. Once it knows
    /// what type of grid to create it uses that grid's `mapFooToRows` function to convert the `SwatchModels` into the proper specialization of row models.
    /// Those row models are then used to construct the final grid.
    /// - Returns: A grid view containing the models for the selected grid. If there's some sort of error it returns a simple `Text` describing the error.
    func gridView() -> some View {
        let view: AnyView
        
        if let colorModels = self.gridModels[selectedGridIndex].models as? [ColorModel] {
            let grid = ColorSwatchGrid(rowModels: ColorSwatchGrid.mapColorsToRows(colorModels: colorModels))
            view = AnyView(grid)
        } else if let textModels = self.gridModels[selectedGridIndex].models as? [TextModel] {
            let grid = TextSwatchGrid(rowModels: TextSwatchGrid.mapTextsToRows(textModels: textModels))
            view = AnyView(grid)
        } else {
            view = AnyView(Text("Missing Grid Type!"))
        }
        
        return view
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(gridModels: [GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors()),
                         GridModel(name: "Text", models: TextModel.textModels())])
    }
}

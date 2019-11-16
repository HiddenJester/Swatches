//
//  MainList.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Combine

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var envScheme: ColorScheme

    let gridModels: [GridModel]
    
    @State private var selectedGridIndex = 0
        
    @State private var darkModeSelected = false
    
    var body: some View {
        VStack {
            GridHeader(darkModeSelected: $darkModeSelected, gridIndex: $selectedGridIndex, gridModels: gridModels)

            SwatchGrid(rowModels: SwatchGrid.mapColorsToRows(colorModels: self.gridModels[selectedGridIndex].models))
            
        }.background(Color(UIColor.systemBackground))
            .onAppear { self.darkModeSelected = (self.envScheme == .dark) }
            .colorScheme(darkModeSelected ? .dark : .light)
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(gridModels: [GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors()),
                         GridModel(name: "Semantic", models: ColorModel.semanticColors())])
    }
}

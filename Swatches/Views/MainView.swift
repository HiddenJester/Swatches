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
            GridHeader(darkModeSelected: $darkModeSelected,
                       gridIndex: $selectedGridIndex,
                       gridNames: gridModels.map { $0.name })
            
            gridView()
            
        }.background(Color.systemBackground)
            .onAppear { self.darkModeSelected = (self.envScheme == .dark) }
            .colorScheme(darkModeSelected ? .dark : .light)
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
    }
    
    
}

private extension MainView {
    func gridView() -> some View {
        let view: AnyView
        
        if let colorModels = self.gridModels[selectedGridIndex].models as? [ColorModel] {
            let grid = ColorSwatchGrid(rowModels: ColorSwatchGrid.mapColorsToRows(colorModels: colorModels))
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
                         GridModel(name: "Semantic", models: ColorModel.semanticColors())])
    }
}

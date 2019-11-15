//
//  MainList.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct GridList: View {
    let grids: [GridModel]
    
    var body: some View {
        ScrollView {
            ForEach(grids) { grid in
                Divider()
                
                SwatchGrid(title: grid.name, models: grid.models)
            }
        }
    }
}

struct GridList_Previews: PreviewProvider {
    static var previews: some View {
        GridList(gridModels: [GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors()),
                         GridModel(name: "Semantic", models: ColorModel.semanticColors())])
    }
}

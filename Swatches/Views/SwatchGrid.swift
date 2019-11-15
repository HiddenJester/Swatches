//
//  ContentView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SwatchGrid: View {
    let models: [ColorModel]
    
    var body: some View {
        ScrollView {
            ForEach(pairRows(models: models)) { SwatchGridRow(first: $0.first, second: $0.second) }
        }.padding()
    }
    
    func pairRows(models: [ColorModel]) -> [SwatchGridRowModel] {
        var rows = [SwatchGridRowModel]()
        
        (0 ..< models.count / 2).forEach { rowIndex in
            let firstIndex = rowIndex * 2
            rows.append(SwatchGridRowModel(first: models[firstIndex], second: models[firstIndex + 1]))
        }
        
        // Catch the odd one out
        if !models.count.isMultiple(of: 2) {
            rows.append(SwatchGridRowModel(first: models.last!, second: nil))
        }
        
        return rows
     }
}

struct SwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwatchGrid(models: ColorModel.swiftUIColors())
        }
    }
}

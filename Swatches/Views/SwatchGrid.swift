//
//  ContentView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct GridRow: Identifiable {
    let id =  UUID()
    
    let first: ColorModel
    
    let second: ColorModel?
}

struct SwatchGrid: View {
    let title: String
    let models: [ColorModel]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
         
            ForEach(pairRows(models: models)) { row in
                HStack {
                    ColorSwatch(model: row.first)

                    if row.second != nil {
                        ColorSwatch(model: row.second!)
                    }
                    else {
                        Spacer().padding()
                    }
                }
            }
        }.padding()
    }
    
    func pairRows(models: [ColorModel]) -> [GridRow] {
        let midpoint = models.count / 2
        let first = models[0 ..< midpoint]
        let second = models[midpoint ..< models.count]

        let tuples = Array(zip(first, second))
        var rows: [GridRow] = tuples.map { GridRow(first: $0, second: $1) }
        // Catch the odd one out
        if !models.count.isMultiple(of: 2) {
            rows.append(GridRow(first: second.last!, second: nil))
        }
        
        return rows
     }
}

struct SwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwatchGrid(title: "Previews", models: ColorModel.previewModels())
        }
    }
}

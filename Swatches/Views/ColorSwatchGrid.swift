//
//  ColorSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ColorSwatchGrid: View {
    typealias RowModel = GridRowModel<ColorModel>
    
    let rowModels: [RowModel]
    
    var body: some View {
        ScrollView {
            ForEach(rowModels) { ColorGridRow(first: $0.first, second: $0.second) }
            
        }
    }
}

extension ColorSwatchGrid {
    static func mapColorsToRows(colorModels: [ColorModel]) -> [RowModel] {
        var rows = [RowModel]()

        (0 ..< colorModels.count / 2).forEach { rowIndex in
            let firstIndex = rowIndex * 2
            rows.append(GridRowModel(first: colorModels[firstIndex], second: colorModels[firstIndex + 1]))
        }

        // Catch the odd one out
        if !colorModels.count.isMultiple(of: 2) {
            rows.append(GridRowModel(first: colorModels.last!, second: nil))
        }

        return rows
    }
}

struct ColorSwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ColorSwatchGrid(rowModels: ColorSwatchGrid.mapColorsToRows(colorModels: ColorModel.swiftUIColors()))
        }
    }
}

//
//  SwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SwatchGrid: View {
    let rowModels: [SwatchGridRowModel]
    
    var body: some View {
        ScrollView {
            ForEach(rowModels) { SwatchGridRow(first: $0.first, second: $0.second) }
            
        }
    }
}

extension SwatchGrid {
    static func mapColorsToRows(colorModels: [ColorModel]) -> [SwatchGridRowModel] {
        var rows = [SwatchGridRowModel]()

        (0 ..< colorModels.count / 2).forEach { rowIndex in
            let firstIndex = rowIndex * 2
            rows.append(SwatchGridRowModel(first: colorModels[firstIndex], second: colorModels[firstIndex + 1]))
        }

        // Catch the odd one out
        if !colorModels.count.isMultiple(of: 2) {
            rows.append(SwatchGridRowModel(first: colorModels.last!, second: nil))
        }

        return rows
    }
}

struct SwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwatchGrid(rowModels: SwatchGrid.mapColorsToRows(colorModels: ColorModel.swiftUIColors()))
        }
    }
}

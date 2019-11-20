//
//  TextSwatchGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct TextSwatchGrid: View {
    typealias RowModel = GridRowModel<TextModel>
    
    let rowModels: [RowModel]
    
    var body: some View {
        ScrollView {
            ForEach(rowModels) { Text($0.first!.name) }
            
        }
    }
}

extension TextSwatchGrid {
    static func mapTextsToRows(textModels: [TextModel]) -> [RowModel] {
        let rows: [RowModel] = textModels.map { RowModel(first: $0, second: nil) }
        
        return rows
    }
}
struct TextSwatchGrid_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatchGrid(rowModels: TextSwatchGrid.mapTextsToRows(textModels: TextModel.textModels()))
    }
}

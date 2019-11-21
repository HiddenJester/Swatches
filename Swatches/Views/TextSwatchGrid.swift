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
    
    @State private var sample = "The quick brown fox jumps over the lazy dog."
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Sample:")
                    .font(.title)

                TextField("Sample Text:", text: $sample)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()

            }.overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
            
            ScrollView {
                ForEach(rowModels) { TextGridRow(model: $0.first, sample: self.sample) }
                
            }.padding(.vertical)
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

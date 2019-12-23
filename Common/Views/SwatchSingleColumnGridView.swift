//
//  SwatchSingleColumnGridView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-23.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A Swatch "grid" that displays everything in a single column.
struct SwatchSingleColumnGridView<CellView: View, RowModel: SwatchModel>: View {
    /// The models to display, one per row.
    let rowModels: [RowModel]
    
    /// A closure that takes an individual model and returns the proper view for that model.
    let contentClosure: (RowModel) -> CellView

    var body: some View {
        ForEach(0 ..< rowModels.count) { self.contentClosure(self.rowModels[$0]) }

    }
}

struct SwatchSingleColumnGridView_Previews: PreviewProvider {
    static var previews: some View {
        SwatchSingleColumnGridView(rowModels: TextModel.textModels(),
                                   contentClosure: { (model: TextModel) in
                                    Text(model.name)
        })
    }
}


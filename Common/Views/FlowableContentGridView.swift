//
//  FlowableContentGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-24.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A generic container view that can arrange "cell" views into a grid. It takes a an "optimal" width for a cell, as well as a maximum count of columns to allow,
/// as well as a closure that maps a `Model` object into a `CellView`. Given the optimal width of the cell and the available width it determines how many
/// columns to flow the cells into.
/// - Note: The "grid" is a loose one, notably cells can be different heights in a row. Also if the last row doesn't have a full list of cells then those cells will
///     larger and not aligned into the same columns as the bulk of the view.
struct FlowableContentGridView<CellView: View, Model: Hashable>: View {
    /// The models to display
    let models: [Model]
    
    /// The optimal width we'd like a CellView to occupy
    let optimalCellWidth: CGFloat
    
    /// The maximum number of columns to allow
    let maxColumns: Int
    
    /// A closure that takes an individual model and returns the proper view for that model.
    let contentClosure: (Model?) -> CellView
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                ForEach(self.splitIntoRows(columnCount: self.columnCount(gridWidth: proxy.size.width)),
                        id: \.self) { (row) in
                            FocusableView() {
                                HStack(alignment: .top) {
                                    ForEach(0 ..< row.count) { (index) in
                                        Group {
                                            if row[index] != nil {
                                                self.contentClosure(row[index])
                                            } else {
                                                EmptyView()
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                }
                
            }
            
        }
    }
}

private extension FlowableContentGridView {
    /// Simple helper function that determine how many columns to display. This takes into account the width of the grid itself, the provided optimal cell width,
    /// as well as the maximum number of columns allowed.
    /// - Parameter gridWidth: The width of the overall grid. Acquired from a `GeometryReader` proxy.
    /// - Returns: The number of columns the grid should render.
    /// - Note: If `gridWidth` is less than `optimalCellWidth` this will return a minimum of 1 column, unless `maxColumns` is set to something
    ///     dumb like 0 or a negative number. Do don't that.
    func columnCount(gridWidth: CGFloat) -> Int {
        min(max(Int(gridWidth / self.optimalCellWidth), 1), maxColumns)
    }
    
    /// A helper function that splits the model array into a two dimensional array with the given column count. This is suitable for iteration to generate rows
    /// of the final grid.
    /// - Parameter columnCount: The number of columns to break `models` into.
    /// - Returns: An array of `[Model?]` objects. Each individual array contains the models to render a single row of the grid.
    /// - Note: Because the last row may not have a full count for the column, the last row may contain some `nil` entries. There is no attempt to
    ///     "center" the remaining models, all of the `nils` will be at the end of the final row.
    func splitIntoRows(columnCount: Int) -> [[Model?]] {
        /// The accumulated final result.
        var result = [[Model?]]()
        
        /// The index that walks the original `models` array.
        var modelIndex = 0
        
        /// How many rows we'll need, given `columnCount` and the number of models provided. Note that this rounds *UP* if
        /// `models.count % columnCount` is not zero. In that case, the final row will have some empty values..
        let rowCount = Int(ceil(Float(models.count) / Float(columnCount)))
        
        (0 ..< rowCount).forEach { (rowIndex) in
            var row = [Model?]()
            (0 ..< columnCount).forEach { _ in
                row.append(modelIndex < models.count ? models[modelIndex] : nil)
                modelIndex += 1
            }
            result.append(row)
        }
        
        return result
    }
}

struct FlowableContentGridView_Previews: PreviewProvider {
    static let optimalWidth = CGFloat(150)
    
    static var previews: some View {
        FlowableContentGridView(models: ColorModel.adaptableColors(),
                                optimalCellWidth: optimalWidth,
                                maxColumns: 5) { (model: ColorModel?) in
                                    ColorSwatchView(model: model)
                                        .previewLayout(PreviewLayout.sizeThatFits)
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

//
//  FlowableContentGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-24.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

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
                ForEach(self.splitIntoRows(columnCount: self.columnCount(maxWidth: proxy.size.width)),
                        id: \.self) { (row) in
                            FocusableRowView {
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
    func columnCount(maxWidth: CGFloat) -> Int {
        min(max(Int(maxWidth / self.optimalCellWidth), 1), maxColumns)
    }
    
    func splitIntoRows(columnCount: Int) -> [[Model?]] {
        var result = [[Model?]]()
        var modelIndex = 0
        
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
        FlowableContentGridView(models: ColorModel.swiftUIColors(),
                                optimalCellWidth: optimalWidth,
                                maxColumns: 5) { (model: ColorModel?) in
                                    ColorSwatchView(model: model, maxWidth: optimalWidth)
        }
    }
}

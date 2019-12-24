//
//  FlowableContentGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-24.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

//struct FocusableGridRowView<Content>: View where Content: View {
//    /// Content passed in to render.
//    private let content: Content
//
//    /// When the content has focus, scale it up by this value in order to see where the focus is.
//    @State private var scale = CGFloat(1)
//
//    var body: some View {
//        platformSpecificView()
//
//    }
//
//    init(@ViewBuilder _ content: @escaping () -> Content) {
//        self.content = content()
//    }
//}

struct FlowableContentGridView<CellView: View, Model: Hashable>: View {
    /// The models to display
    let models: [Model]
    
    /// The maximum width we'd like a CellView to occupy
    let maxCellWidth: CGFloat
    
    /// A closure that takes an individual model and returns the proper view for that model.
    let contentClosure: (Model?) -> CellView
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ForEach(self.splitIntoRows(columnCount: max(Int(proxy.size.width / self.maxCellWidth), 1)),
                        id: \.self) { (row) in
                            FocusableGridRowView {
                                HStack {
                                    ForEach(0 ..< row.count) { (index) in
                                        self.contentClosure(row[index])
                                    }
                                }
                            }
                }
            }
        }
    }
}

private extension FlowableContentGridView {
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

struct FlowableContentGrid_Previews: PreviewProvider {
    static var previews: some View {
        FlowableContentGridView(models: ColorModel.swiftUIColors(),
                            maxCellWidth: 150) { (model: ColorModel?) in ColorSwatchView(model: model) }
    }
}

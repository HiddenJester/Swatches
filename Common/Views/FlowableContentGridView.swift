//
//  FlowableContentGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-24.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A generic container view that can arrange "cell" views into a grid. It takes a closure that maps a `Model` object into a `CellView` as well a
/// a sample `Model` that can generate an cell with a desired width of the cell. The Grid renders a hidden `CellView` using `widthSampleModel` and
/// uses the resulting width to calculate how many columns can be supported.
/// - Note: The "grid" is a loose one, notably cells can be different heights in a row.
struct FlowableContentGridView<CellView: View, Model: Hashable>: View {
    /// The models to display.
    let models: [Model]

    /// A model that will generate the sample cell used to determine width. Primarily this is done so that dynamic type can be used and we still get a usable
    /// number of columns. Note that if `CellView` can support multiline text then you don't want to provide the *longest* string you want, but it's
    /// better to provide what you'd like a *single* line to represent. I'm currently using the word "Tertiary" as a label, meaning strings such as
    /// "Tertiary System Background" will become three lines.
    let widthSampleModel: Model

    /// A closure that takes an individual model and returns the proper view for that model.
    let contentClosure: (Model?, CGSize?) -> CellView

    /// Once `widthSampleModel` is rendered, the width of it is stored here.
    @State private var cellWidth = CGFloat(0)

    /// This value is set by calling `syncingHeightIfLarger(than:)` in order to find the tallest cell in the whole grid and use it as a frame height
    /// for all 
    @State private var cellHeight = CGFloat(0)

    /// Once `columnWidth` is determined, we can divide the window width by that and generate the number of columns we want to use in the grid.
    @State private var columnCount = Int(0)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColumnWidthFindingView(fullWidth: geometry.size.width,
                                       columnWidth: $cellWidth,
                                       columnCount: $columnCount) {
                    self.contentClosure(widthSampleModel, nil)
                }
                .hidden()

                HStack {
                    Spacer()

                    ScrollView(.vertical) {
                        ForEach(splitIntoRows(columnCount: columnCount), id: \.self) { (row) in
                            HStack {
                                ForEach(row, id: \.self) { model in
                                    contentClosure(model, CGSize(width: cellWidth, height: cellHeight))
                                        .updatingCachedHeightIfTaller(than: $cellHeight)
                                }
                            }
                        }
                    }
                    .frame(minWidth: CGFloat(columnCount) * cellWidth)

                    Spacer()
                }

                // Old school debugging aid 😜
//                VStack {
//                    Text("Column Width: \(columnWidth)")
//
//                    Text("Column Count: \(columnCount)")
//                }
//                .foregroundColor(.red)
//                .font(.title)
//                .background(Color.gray)
            }
        }
    }
}

private extension FlowableContentGridView {
    /// A helper function that splits the model array into a two dimensional array with the given column count. This is suitable for iteration to generate rows
    /// of the final grid.
    /// - Parameter columnCount: The number of columns to break `models` into.
    /// - Returns: An array of `[Model?]` objects. Each individual array contains the models to render a single row of the grid.
    /// - Note: Because the last row may not have a full count for the column, the last row may contain some `nil` entries. There is no attempt to
    ///     "center" the remaining models, all of the `nils` will be at the end of the final row.
    func splitIntoRows(columnCount unboundedColumnCount: Int) -> [[Model?]] {
        let columnCount = max(unboundedColumnCount, 1)
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

/// A PreferenceKey we use to store the height of the tallest cell we have.
private struct CellHeightPreferenceKey: PreferenceKey {
    static let defaultValue = CGFloat(0)

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private extension View {
    /// Creates the needed geometry reader to extract the height.
    /// - Parameter than: A `Binding<CGFloat>` where the height will be stored.
    /// - Returns: a clear background view and as a side effect can update `than`.
    func updatingCachedHeightIfTaller(than height: Binding<CGFloat>) -> some View {
        background(GeometryReader { geometry in
            Color.clear
                .hidden()
                .preference( key: CellHeightPreferenceKey.self, value: geometry.size.height)
        })
        // Note: You can't call .hidden() on the background or the PreferenceKey will not update.
        // The 1.02 pads the returned height a tiny bit. This primarily pushes the edge a bit away from any
        // descenders in the label text.
        .onPreferenceChange(CellHeightPreferenceKey.self) { height.wrappedValue = max(height.wrappedValue, $0 * 1.02) }
    }
}

/// A view that takes a view, a full width value, and bindings for the desired column width and column count.
private struct ColumnWidthFindingView<Content: View>: View {
    /// The full width of the parent view to break into columns.
    private let fullWidth: CGFloat

    /// The final columnWidth will be stored in this binding.
    private let columnWidth: Binding<CGFloat>

    /// The final columanCount will be stored in this binding.
    private let columnCount: Binding<Int>

    /// A sample view to render and extract the width from.
    private let content: Content

    init(fullWidth: CGFloat,
         columnWidth: Binding<CGFloat>,
         columnCount: Binding<Int>,
         @ViewBuilder content: () -> Content) {

        self.columnWidth = columnWidth
        self.fullWidth = fullWidth
        self.columnCount = columnCount
        self.content = content()
    }

    var body: some View {
        content
            .background(GeometryReader { geometry in
                widthUpdatingView(width: geometry.size.width)
            })
    }
}

private extension ColumnWidthFindingView {
    /// Returns a clear view that takes up the specfied width. This is used to calculate the changes we need for the binding.
    /// - Parameter width: the width we want for a single cell.
    /// - Returns: A dummy view that can be stuffed in a GeometryReader so the calculation gets made properly.
    func widthUpdatingView(width: CGFloat) -> some View {
        // Decrease the geometry width a hair so we don't shove RIGHT up to the margins in the event
        // that the width is an exact multiple of sampleWidth and also leave some room for column spacing.
        let scaledFullWidth = fullWidth * 0.95

        // Boundscheck the input.
        let boundedWidth = max(width, 1)

        // This will change the views, so delay it slightly.
        DispatchQueue.main.async {
            // If the sample is wider than the full width, then just return full width and set column count to 1
            if boundedWidth > scaledFullWidth {
                self.columnCount.wrappedValue = 1
            } else {
                self.columnCount.wrappedValue = Int(scaledFullWidth / boundedWidth)
            }
            // Now, let the columns take up as much space as possible.
            self.columnWidth.wrappedValue = scaledFullWidth / CGFloat(self.columnCount.wrappedValue)
        }

        return Color.clear
            .frame(width: width)
    }
}

struct FlowableContentGridView_Previews: PreviewProvider {
    static var previews: some View {
        FlowableContentGridView(models: ColorModel.adaptableColors(),
                                widthSampleModel: ColorModel.widthSample) { ColorSwatchView(model: $0, size: $1) }
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}

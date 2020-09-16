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
struct FlowableContentGridView<Header: View, CellView: View, Model: Hashable>: View {
    /// A view to draw at the top of the scrolling area.
    let headerView: Header

    /// The models to display.
    let models: [Model]

    /// A model that will generate the sample cell used to determine width. Primarily this is done so that dynamic type can be used and we still get a usable
    /// number of columns. Note that if `CellView` can support multiline text then you don't want to provide the *longest* string you want, but it's
    /// better to provide what you'd like a *single* line to represent. I'm currently using the word "Tertiary" as a label, meaning strings such as
    /// "Tertiary System Background" will become three lines.
    let widthSampleModel: Model

    /// Our layout to use for the cells. This updated from the `PreferenceKey`, but handled asynch so that A ) all of the changes are coalesced and B )
    /// we can animate opacity on layout changes.
    @State private var layout = FlowableContentGridLayout()

    /// The opacity value used for the entire view. This can be animated by layout changes.
    @State private var opacity: Double = 1

    /// A closure that takes an individual model and an optional width value and returns the proper view for that model.
    let contentClosure: (Model?, CGFloat?) -> CellView

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.contentClosure(self.widthSampleModel, nil)
                    .updatingLayoutWidthAndColumnCount(forFullWidth: geometry.size.width)
                    .hidden()

                ScrollView() {
                    self.headerView

                    ForEach(self.splitIntoRows(columnCount: self.layout.getColumnCount()), id: \.self) { (row) in
                        HStack {
                            ForEach(row, id: \.self) { model in
                                // If we have a cellWidth use it, otherwise just use the full geometry width.
                                self.contentClosure(model, self.layout.cellWidth ?? geometry.size.width)
                                    .updatingLayoutHeight()
                            }
                            .frame(height: self.layout.getHeight())
                        }
                    }
                }
                .frame(width: self.layout.gridWidth ?? geometry.size.width, height: geometry.size.height)

//                self.debugLayoutView()
            }
        }
        .opacity(opacity)
        .onPreferenceChange(LayoutPreferenceKey.self) { layout in
            DispatchQueue.main.async { self.update(fromLayout: layout)
            }
        }
    public init(models: [Model], widthSampleModel: Model, @ViewBuilder header: () -> Header, contentClosure: @escaping (Model?, CGFloat?) -> CellView) {
        self.headerView = header()
        self.models = models
        self.widthSampleModel = widthSampleModel
        self.contentClosure = contentClosure
    }
}

// MARK: - FlowableContentGridView private funcs
private extension FlowableContentGridView {
    /// An old school debugging aid. This simply displays some of the value from the layout.
    /// - Returns: A view with the values displayed, suitable for sticking in the `ZStack` for run-time debugging.
    #if DEBUG
    func debugLayoutView() -> some View {
        // Old school debugging aid 😜
        VStack {
            Text("Cell Width: \(self.layout.getWidth())")

            Text("Cell Height: \(self.layout.getHeight())")

            Text("Grid Width: \(self.layout.gridWidth ?? 0)")

            Text("Column Count: \(self.layout.getColumnCount())")
        }
        .foregroundColor(.red)
        .font(.headline)
        .background(Color.gray)
    }
    #endif

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

    /// Reduces `self.layout` with a new value. on iOS & watchOS this will animate `.opacity`. on macOS (Catalyst) this only animates `.opacity`
    /// if the column count changes during the reduction.
    /// - Parameter fromLayout: The new layout value to reduce into `self.layout`.
    func update(fromLayout newLayout: FlowableContentGridLayout) {
        let animateUpdate: Bool

        let oldColumnCount = self.layout.getColumnCount()

        layout.reduce(newValue: newLayout)

        #if targetEnvironment(macCatalyst)
        animateUpdate = oldColumnCount != self.layout.getColumnCount()
        #else
        animateUpdate = true
        #endif

        if animateUpdate {
            self.opacity = 0
            withAnimation(.easeInOut(duration: 0.5)) { self.opacity = 1 }
        }
    }
}

// MARK: - FlowableContentGridLayout
private struct FlowableContentGridLayout {
    /// The width to apply to a single cell.
    var cellWidth: CGFloat? = nil

    /// The height to apply to a single cell.
    var cellHeight: CGFloat? = nil

    var gridWidth: CGFloat? = nil

    /// The number of columns to render into the grid.
    var columnCount: Int? = nil
}

private extension FlowableContentGridLayout {
    /// Unwraps width into a definite `CGFloat`. Returns 0 if no value is available.
    /// - Returns: a valid `CGFloat` for `cellWidth`.
    func getWidth() -> CGFloat { cellWidth ?? 0 }

    /// Unwraps height into a definite `CGFloat`. Returns 0 if no value is available.
    /// - Returns: a valid `CGFloat` for `cellHeight`.
    func getHeight() -> CGFloat { cellHeight ?? 0 }

    /// Unwraps columnCount into a definite `Int`. Returns 1 if no value is available.
    /// - Returns: a valid `Int` for `columnCount`.
    func getColumnCount() -> Int { columnCount ?? 1 }

    /// Takes a new `FlowableGridContentLayout` and reduces it into this one. This combines partial layouts (if this layout has a width and the new
    /// one has a height, the final value will contain both, for example.) Also, setting the width resets the height value (since we need to recalculate height when
    /// the width changes). Lastly, height is only ever *increased* during a reduce operation (except for when width is changed), a shorter height than is currently
    /// present is simply discarded.
    /// - Parameter newValue: The value to reduce in this one.
    mutating func reduce(newValue: FlowableContentGridLayout) {
        if let newGridWidth = newValue.gridWidth, newGridWidth != gridWidth {
            gridWidth = newGridWidth
            cellHeight = nil
            cellWidth = nil
            columnCount = nil
        }

        if let newWidth = newValue.cellWidth, newWidth != cellWidth {
            cellWidth = newWidth
            // Changing cell width needs to reset the height value.
//            print ("Resetting height due to width change.")
            cellHeight = nil
        }

        if let newCount = newValue.columnCount, newCount != columnCount {
            columnCount = newCount
        }

        if let newHeight = newValue.cellHeight, newHeight > getHeight() {
//            print ("Increasing height from \(String(describing: cellHeight)) to \(newHeight)")
            cellHeight = newHeight
//        } else if let newHeight = newValue.cellHeight {
//            print ("Discarding height value \(newHeight)")
        }
    }
}

extension FlowableContentGridLayout: Equatable {}

// MARK: - LayoutPreferenceKey
/// A PreferenceKey we use to update the layout properties.
private struct LayoutPreferenceKey: PreferenceKey {
    static let defaultValue = FlowableContentGridLayout()

    static func reduce(value: inout FlowableContentGridLayout, nextValue: () -> FlowableContentGridLayout) {
        value.reduce(newValue: nextValue())
    }
}

private extension View {
    /// Creates the needed geometry reader to extract the height.
    /// - Returns: a clear background view that set the height into the `LayoutPreferenceKey`.
    func updatingLayoutHeight() -> some View {
        background(GeometryReader { geometry in
            // Note: You can't call .hidden() on the background or the PreferenceKey will not update.
            Color.clear
                .hidden() // But you can hide the contents of the GeometryReader … 🤷‍♂️
                .preference(key: LayoutPreferenceKey.self,
                            value: FlowableContentGridLayout(cellHeight: geometry.size.height))
        })
    }

    /// Creates the needed geometry reader to extract the width.
    /// - Parameter viewFullWidth: the width of the full view that should be split into columns
    /// - Returns: a clear background view that set the width and the column count into the `LayoutPreferenceKey`.
    func updatingLayoutWidthAndColumnCount(forFullWidth: CGFloat) -> some View {
        background(GeometryReader { geometry in
            // Note: You can't call .hidden() on the background or the PreferenceKey will not update.
            Color.clear
                .hidden() // But you can hide the contents of the GeometryReader … 🤷‍♂️
                .frame(width: geometry.size.width)
                .preference(key: LayoutPreferenceKey.self,
                            value: self.createWidthUpdatingLayout(columnWidth: geometry.size.width,
                                                             viewFullWidth: forFullWidth))
        })
    }

    func createWidthUpdatingLayout(columnWidth: CGFloat, viewFullWidth: CGFloat) -> FlowableContentGridLayout {
        // Decrease the geometry width a hair so we don't shove RIGHT up to the margins in the event
        // that the width is an exact multiple of sampleWidth and also leave some room for column spacing.
        let scaledFullWidth = viewFullWidth * 0.9

        // Boundscheck the input.
        let boundedCellWidth = max(columnWidth, 1)

        let columnCount: Int

        // If the sample is wider than the full width, then just set the column count to 1
        if boundedCellWidth > scaledFullWidth {
            columnCount = 1
        } else {
            columnCount = Int(scaledFullWidth / boundedCellWidth)
        }

        // Let the new cell width be as wide as possible, inside scaled FullWidth.
        return FlowableContentGridLayout(cellWidth: scaledFullWidth / CGFloat(columnCount),
                                         cellHeight: nil,
                                         gridWidth: viewFullWidth,
                                         columnCount: columnCount)
    }
}

struct FlowableContentGridView_Previews: PreviewProvider {
    static var previews: some View {
        FlowableContentGridView(models: ColorModel.adaptableColors(),
                                widthSampleModel: ColorModel.widthSample,
                                header: { EmptyView() }) { ColorSwatchView(model: $0, width: $1) }
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}

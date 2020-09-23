//
//  FlowableContentGrid.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-24.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A generic container view that can arrange "cell" views into a grid. It takes a closure that maps a `Model` object into a `CellView` as well a
/// a sample `Model` that can generate an cell that would provide a reasonable desired cell width. The grid renders a hidden `CellView` using
/// `widthSampleModel` and uses the resulting width to calculate how many columns can be supported, as well as whether we can render the os tags in
/// the wide 4-column mode or the narrower 2-column mode. (See `SupportedOSTagView.swift` for more on that.)
struct FlowableContentGridView<Header: View, CellView: View, Model: Hashable>: View {
    /// A view to draw at the top of the scrolling area.
    let headerView: Header

    /// The models to display.
    let models: [Model]

    /// A model that will generate the sample cell used to determine width. Primarily this is done so that dynamic type can be used and we still get a usable
    /// number of columns. Note that if `CellView` can support multiline text then you don't want to provide the *longest* string you want, but it's
    /// better to provide what you'd like a *single* line to represent. I'm currently using "Secondary Background" as a label, meaning strings such as
    /// "Tertiary System Background" will become two lines.
    let widthSampleModel: Model

    /// A closure that takes an individual model and an optional width value and returns the proper view for that model.
    let contentClosure: (Model?, CGFloat?) -> CellView

    /// Our layout to use for the cells. This updated from the `PreferenceKey`, but handled asynch so that A ) all of the changes are coalesced and B )
    /// we can animate opacity on layout changes.
    @State private var layout = FlowableContentGridLayout()

    /// The opacity value used for the entire view. This can be animated by layout changes.
    @State private var opacity: Double = 1

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                contentClosure(widthSampleModel, nil)
                    .updatingLayout(forFullWidth: geometry.size.width)
                    .hidden()

                ScrollView() {
                    headerView

                    ForEach(splitIntoRows(columnCount: layout.columnCount), id: \.self) { (row) in
                        HStack(spacing:layout.columnGap) {
                            ForEach(row, id: \.self) { model in
                                // If we have a cellWidth use it, otherwise just use the full geometry width.
                                self.contentClosure(model,
                                                    (layout.cellWidth > 0) ? layout.cellWidth : geometry.size.width)
                            }
                        }
                        /// Force each row to *precisely* be the width we want. Otherwise the cells get … creative when
                        /// there is a large gap between this row width and the grid's full width.
                        .frame(width: layout.rowWidth() ?? geometry.size.width)
                    }
                }
                .frame(width: (layout.gridWidth == 0) ? layout.gridWidth : geometry.size.width,
                       height: geometry.size.height)

//                layout.debugView()
            }
            /// Set the tagFormat into the environment so `SupportedOSTagView` can pick it up and use it.
            .environment(\.supportedOSTagFormat, layout.tagFormat)
            .onPreferenceChange(LayoutPreferenceKey.self) { update(fromLayout: $0) }
        }
        .opacity(opacity)
    }

    public init(models: [Model],
                widthSampleModel: Model,
                @ViewBuilder header: () -> Header, contentClosure: @escaping (Model?, CGFloat?) -> CellView) {
        self.headerView = header()
        self.models = models
        self.widthSampleModel = widthSampleModel
        self.contentClosure = contentClosure
    }
}

// MARK: - FlowableContentGridView private funcs
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

    /// Replaces `self.layout` with a new value. on iOS & watchOS this will animate `.opacity`. on macOS (Catalyst) this only animates `.opacity`
    /// if the column count changes.
    /// - Parameter fromLayout: The new layout value to replace `self.layout`.
    func update(fromLayout newLayout: FlowableContentGridLayout) {
        let animateUpdate: Bool

        #if targetEnvironment(macCatalyst)
        animateUpdate = newLayout.columnCount != layout.columnCount
        #else
        animateUpdate = true
        #endif

        layout = newLayout

        if animateUpdate {
            self.opacity = 0
            withAnimation(.easeInOut(duration: 0.5)) { self.opacity = 1 }
        }
    }
}

// MARK: - FlowableContentGridLayout
private struct FlowableContentGridLayout {
    /// The width to apply to a single cell.
    var cellWidth: CGFloat = 0

    var gridWidth: CGFloat = 0

    /// The spacing to use in the row HStacks.
    var columnGap: CGFloat = 0

    /// The number of columns to render into the grid.
    var columnCount: Int = 1

    /// The tag format to pass in the environment to control tag formatting.
    var tagFormat: SupportedOSTagView.TagFormat = .twoColumn
}

extension FlowableContentGridLayout: Equatable {}

private extension FlowableContentGridLayout {
    /// An old school debugging aid. This simply displays some of the value from the layout.
    /// - Returns: A view with the values displayed, suitable for sticking in the `ZStack` for run-time debugging.
    #if DEBUG
    func debugView() -> some View {
        VStack {
            Text("Cell Width: \(cellWidth)")

            Text("Grid Width: \(gridWidth)")

            Text("Column Count: \(columnCount)")

            Text("Column Gap: \(columnGap)")

            switch tagFormat {
            case .twoColumn:
                Text("Tag: 2 Column")

            case .fourColumn:
                Text("Tag: 4 Column")
            }
        }
        .foregroundColor(.red)
        .font(.headline)
        .background(Color.gray)
    }
    #endif

    /// Calculates the width of a single row using this layout.
    /// - Returns: If the layout has a positive `cellWidth` this returns the width a row should be. If `cellWidth` is zero or negative this this returns
    ///     nil, indicating we can't calculate a valid row width yet.
    func rowWidth() -> CGFloat? {
        (cellWidth > 0) ? (cellWidth + columnGap) * CGFloat(columnCount) : nil
    }
}
// MARK: - LayoutPreferenceKey
/// A PreferenceKey we use to update the layout properties.
private struct LayoutPreferenceKey: PreferenceKey {
    static let defaultValue = FlowableContentGridLayout()

    static func reduce(value: inout FlowableContentGridLayout, nextValue: () -> FlowableContentGridLayout) {}
}

private extension View {
    /// Creates the needed geometry readers to extract the width and select a tag format..
    /// - Parameter viewFullWidth: the width of the full view that should be split into columns
    /// - Returns: a clear background view that sets a new `FlowableContentGridLayout` into the `LayoutPreferenceKey`.
    func updatingLayout(forFullWidth viewWidth: CGFloat) -> some View {
        background(GeometryReader { widthSampleGeometry in
            /// widthSampleGeometry describes the widthSample. Specifically, the width should be our desired column width.
            /// Now draw a four column OS tag view.
            SupportedOSTagView(value: .all, opacity: 1, overrideTagFormat: .fourColumn)
                // Force it to use it's true horizontal size, so it can be wider than the parent sample.
                .fixedSize()
                .background(GeometryReader { tagGeometry in
                    /// now tagGeometry represents what a 4-column tag needs.
                    Color.clear
                        /// And with *both* `widthSampleGeometry` & `tagGeometry`, as well as `viewWidth` we can finally calculate the
                        /// the desired `FlowableContentGridLayout`.
                        .preference(key: LayoutPreferenceKey.self,
                                    value: createWidthUpdatingLayout(columnWidth: widthSampleGeometry.size.width,
                                                                     viewFullWidth: viewWidth,
                                                                     fourColumnTagGeometry: tagGeometry))
                })
        })
    }

    /// The secret sauce at the core of the beast. This builds a `FlowableContentGridLayout` that can be used to flow the rest of the content.
    /// - Parameters:
    ///   - columnWidth: The ideal width for a column of cells.
    ///   - viewFullWidth: The width of the entire grid.
    ///   - fourColumnTagGeometry: a `GeometryProxy` that represents the size of a four-Column `SupportedOSTagView`.
    /// - Returns: The final `FlowableContentGridLayout` that makes everything else sing.
    func createWidthUpdatingLayout(columnWidth: CGFloat,
                                   viewFullWidth: CGFloat,
                                   fourColumnTagGeometry: GeometryProxy) -> FlowableContentGridLayout {
        let desiredColumnGap: CGFloat = 10
        let columnGap: CGFloat = (viewFullWidth > columnWidth + desiredColumnGap) ? desiredColumnGap : 0
        // Boundscheck the input so columnWidth is positive and < viewFullWidth.
        let boundedCellWidth = min(viewFullWidth, max(columnWidth, 1))

        let columnCount: Int

        // If the sample is wider than the full width, then just set the column count to 1
        if boundedCellWidth > viewFullWidth {
            columnCount = 1
        } else {
            columnCount = Int(viewFullWidth / (boundedCellWidth + desiredColumnGap))
        }

        let tagFormat: SupportedOSTagView.TagFormat
        if fourColumnTagGeometry.size.width > boundedCellWidth {
            tagFormat = .twoColumn
        } else {
            tagFormat = .fourColumn
        }

        // Let the new cell width be as wide as possible, inside scaled FullWidth.
        return FlowableContentGridLayout(cellWidth: boundedCellWidth,
                                         gridWidth: viewFullWidth,
                                         columnGap: columnGap,
                                         columnCount: columnCount,
                                         tagFormat: tagFormat)
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

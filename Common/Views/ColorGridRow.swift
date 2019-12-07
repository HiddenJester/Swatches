//
//  SwatchGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that displays `ColorSwatch` views. Since SwiftUI doesn't have a collection controller and Swatches is a lightweight application I simply created a
/// forced 2-column grid by displaying a `ForEach` over a series of `ColorGridRow` objects. This view simply takes two optional `ColorModel` objects,
/// which correspond to the left and right `ColorSwatch` objects in the row. If a nil `ColorModel` is passed in a transparent `ColorSwatch` is created
/// for that position. This ensures that a row with a single model will draw the `ColorSwatch` the same size as the other rows, and aligned in the proper column.
struct ColorGridRow: View {
    /// The color model to draw in the left position of this row. If nil is passed a transparent `ColorSwatch` will be drawn.
    let first: ColorModel?
    
    /// The color model to draw in the right position of this row. If nil is passed a transparent `ColorSwatch` will be drawn.
    let second: ColorModel?
    
    var body: some View {
        HStack {
            ColorSwatch(model: first)

            ColorSwatch(model: second)

        }.padding()
    }
}

struct ColorGridRow_Previews: PreviewProvider {
    static var models = ColorModel.swiftUIColors()
    
    static var previews: some View {
        Group {
            ColorGridRow(first: models[0], second: models[1])
            
            ColorGridRow(first: models[2], second: nil)
            
            ColorGridRow(first: nil, second: models[3])
        }
    }
}

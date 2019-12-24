//
//  ColorSwatchSingleColumnGridView.swift
//  Swatches-watchOS WatchKit Extension
//
//  Created by Timothy Sanders on 2019-12-23.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A "grid" view that draws `ColorSwatch` objects in `SwatchSingleColumnGridView`.
/// - Parameter rowModels: The raw `ColorModel` objects that need to be rendered.
struct ColorSwatchSingleColumnGridView: View {
    let rowModels: [ColorModel]
    
    var body: some View {
        ScrollView {
            
            SwatchSingleColumnGridView(rowModels: rowModels) { (model) in
                ColorSwatchView(model: model)
                
            }
        }
    }
}

struct ColorSwatchSingleColumnGridView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSwatchSingleColumnGridView(rowModels: ColorModel.swiftUIColors())
    }
}

//
//  SwatchGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SwatchGridRow: View {
    let first: ColorModel?
    
    let second: ColorModel?
    
    var body: some View {
        HStack {
            ColorSwatch(model: first)

            ColorSwatch(model: second)
        }
    }
}

struct SwatchGridRow_Previews: PreviewProvider {
    static var models = ColorModel.swiftUIColors()
    
    static var previews: some View {
        Group {
            SwatchGridRow(first: models[0], second: models[1])
            SwatchGridRow(first: models[2], second: nil)
            SwatchGridRow(first: nil, second: models[3])
        }
    }
}

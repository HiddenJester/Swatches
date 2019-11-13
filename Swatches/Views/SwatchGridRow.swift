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
    @State static var models = ColorModel.swiftUIColors()
    
    static var previews: some View {
        Group {
            // Skip models[0] which is .clear and doesn't render correctly yet.
            SwatchGridRow(first: models[1], second: models[2])
            SwatchGridRow(first: models[3], second: nil)
        }
    }
}

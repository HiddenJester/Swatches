//
//  SwatchGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SwatchGridRow: View {
    let first: ColorModel
    
    let second: ColorModel?
    
    var body: some View {
        HStack {
            ColorSwatch(model: first)

            if second != nil {
                ColorSwatch(model: second!)
            }
            else {
                Spacer().padding()
            }
        }
    }
}

struct SwatchGridRow_Previews: PreviewProvider {
    @State static var models = ColorModel.previewModels()
    
    static var previews: some View {
        Group {
            SwatchGridRow(first: models[0], second: models[1])
            SwatchGridRow(first: models[2], second: nil)
        }
    }
}

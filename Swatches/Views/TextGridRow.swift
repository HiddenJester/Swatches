//
//  TextGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct TextGridRow: View {
    let model: TextModel?

    let sample: String
    
    var body: some View {
        TextSwatch(sample: sample, model: model)
            .padding()
    }
}

struct TextGridRow_Previews: PreviewProvider {
    static let models = TextModel.textModels()
    static let sample = "The quick brown fox jumps over the lazy dog."
    
    static var previews: some View {
        Group {
            TextGridRow(model: models[0], sample: sample)

            TextGridRow(model: models[4], sample: sample)
        }
    }
}

//
//  TextSwatch.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct TextSwatch: View {
    let sample: String
    
    let model: TextModel?

    private let cornerRadius = CGFloat(20.0)

    var body: some View {
        Swatch(drawBackground: model != nil, label: model?.name ?? " ") {
            HStack {
                Spacer()

                TextChip(text: self.sample, color: self.model?.color ?? .clear)
                
                Spacer()
            }
        }
    }
}

struct TextSwatch_Previews: PreviewProvider {
    static var previews: some View {
        TextSwatch(sample: "The quick brown fox jumps over the lazy dog",
                   model: TextModel(color: .link, name: "Link"))
    }
}

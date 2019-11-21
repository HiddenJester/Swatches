//
//  TextChip.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct TextChip: View {
    let text: String
    
    let color: Color
   
    private let cornerRadius = CGFloat(20.0)

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(color)
            .background(ChipBackground(drawCheckerboard: color != .clear, cornerRadius: cornerRadius))
    }
}

struct TextChip_Previews: PreviewProvider {
    static var previews: some View {
        TextChip(text: "Testing", color: .link)
    }
}

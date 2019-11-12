//
//  ColorView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ColorChip: View {
    let color: Color
    
    private let minSwatchSize = CGFloat(50)
    private let maxSwatchSize = CGFloat(300)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20.0)
            .frame(minWidth: minSwatchSize,
                   maxWidth: maxSwatchSize,
                   minHeight: minSwatchSize,
                   maxHeight: maxSwatchSize)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
            .scaledToFit()
    }
}

struct ColorChip_Previews: PreviewProvider {
    static var previews: some View {
        ColorChip(color: .green)
    }
}

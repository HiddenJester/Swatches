//
//  SwatchLabel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct SwatchLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.label)
            .truncationMode(.middle)
            .lineLimit(1)
            .padding(.vertical)
    }
}

struct SwatchLabel_Previews: PreviewProvider {
    static var previews: some View {
        SwatchLabel(text: "Testing Label")
    }
}

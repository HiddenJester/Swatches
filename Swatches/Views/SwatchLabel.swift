//
//  SwatchLabel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A view that displays a single line of text in the `.label` Color, limited to one line, with truncation set for the middle, and has vertical padding.
/// - Parameter text: The text to display in the label.
struct SwatchLabel: View {
    /// The text to display.
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

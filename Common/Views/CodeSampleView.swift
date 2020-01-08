//
//  CodeSampleView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-01-06.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// Displays provided text in a monospaced font, while allowing a minimum scale of 0.75. By default the text is drawn in `.label` with a background color
/// of `.systemGray4` (`.systemGray` on tvOS), but both colors may be overridden.
struct CodeSampleView: View {
    /// The text to display in the monospaced font.
    let text: String
    
    /// The foreground color of the text. Defaults to `.label`.
    var foregroundColor: Color = .label
    
    #if os(tvOS)
    /// The background colors of the text. Defaults to `.systemGray`.
    var backgroundColor: Color = .systemGray
    #else
    /// The background colors of the text. Defaults to `.systemGray4`.
    var backgroundColor: Color = .systemGray4
    #endif
    
    /// The monospaced font to use.
    private let codeFont = Font.system(.body, design: .monospaced)

    var body: some View {
        Text(text)
            .font(codeFont)
            .minimumScaleFactor(0.75)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
    }
}

struct CodeSampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeSampleView(text: "RoundedRectangle.backgroundColor(.systemGray4)")

            CodeSampleView(text: "Some Link", foregroundColor: .link, backgroundColor: .clear)

        }
    }
}

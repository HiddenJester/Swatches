//
//  FocusableGridRow.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-06.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct FocusableGridRow<Content>: View where Content: View {
    private let content: Content

    @State private var scale = CGFloat(1)
    
    var body: some View {
        platformSpecificView()

    }

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content()
    }
    
    func platformSpecificView() -> some View {
        #if os(tvOS)
        return HStack {
            Spacer()
            
            self.content
                .padding()
                .scaleEffect(self.scale)
                .focusable(true) { focus in withAnimation { self.scale = focus ? 1.1 : 1 } }
            
            Spacer()
        }
        #else
        return content
        #endif
    }
}

struct FocusableGridRow_Previews: PreviewProvider {
    static var models = ColorModel.swiftUIColors()

    static var previews: some View {
        FocusableGridRow() {
            ColorGridRow(first: models[0], second: models[1])
        }
    }
}

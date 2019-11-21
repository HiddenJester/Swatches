//
//  ChipBackground.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-20.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct ChipBackground: View {
    let drawCheckerboard: Bool

    let cornerRadius: CGFloat

    var body: some View {
        view()
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(drawCheckerboard ? Color.black : Color.clear))
    }
}

private extension ChipBackground {
    func view() -> some View {
        if drawCheckerboard {
            let image = Image("Checkerboard")
                .resizable(resizingMode: .tile)
                .cornerRadius(self.cornerRadius)
            
            return AnyView(image)
        } else {
            return AnyView(Color.clear)
        }
    }
}

struct ChipBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChipBackground(drawCheckerboard: true, cornerRadius: 20.0)
            
            ChipBackground(drawCheckerboard: false, cornerRadius: 20.0)
        }
    }
}

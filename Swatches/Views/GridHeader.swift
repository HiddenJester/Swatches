//
//  GridHeader.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-14.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct GridHeader: View {
    @Binding var darkModeSelected: Bool
    
    @Binding var gridIndex: Int
    
    let gridModels: [GridModel]
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $darkModeSelected)

            Picker("Colors:", selection: $gridIndex) {
                ForEach(0 ..< gridModels.count) { index in
                    Text(self.gridModels[index].name).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Divider()

        }
    }
}

struct GridHeader_Previews: PreviewProvider {
    static var previews: some View {
        GridHeader(darkModeSelected: .constant(false),
                   gridIndex: .constant(0),
                   gridModels: [GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors())])
    }
}

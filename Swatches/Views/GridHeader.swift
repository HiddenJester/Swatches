//
//  GridHeader.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-14.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// The header view to draw at the top of the screen. This displays a switch that that controls whether the app is in dark mode and a picker that lists
/// the grid names.
/// - Parameter darkModeSelected: Binding to a Bool that controls whether the app is displaying in dark mode.
/// - Parameter gridIndex: Binding to an Int that controls which grid is displayed.
/// - Parameter gridNames: The strings to display in the grid picker. When a grid is selected `gridIndex` is updated.
struct GridHeader: View {
    /// A bool that controls whether the app is displaying in dark mode or not.
    @Binding var darkModeSelected: Bool
    
    /// The selected grid.
    @Binding var gridIndex: Int
    
    /// The strings to use in the grid picker.
    let gridNames: [String]
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $darkModeSelected)
                .padding(.horizontal)

            Picker("Colors:", selection: $gridIndex) {
                ForEach(0 ..< gridNames.count) { index in
                    Text(self.gridNames[index]).tag(index)
                        .minimumScaleFactor(0.75)
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
                   gridNames: ["SwiftUI"])
    }
}

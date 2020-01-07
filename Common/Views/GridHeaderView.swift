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
struct GridHeaderView: View {
    /// A bool that controls whether the app is displaying in dark mode or not.
    @Binding var darkModeSelected: Bool
    
    /// The selected grid.
    @Binding var gridIndex: Int
    
    /// The strings to use in the grid picker.
    let gridNames: [String]
    
    @State private var showAbout = false
    
    var body: some View {
        VStack {
            #if !os(watchOS) // watchOS doesn't support dark/light mode or have the About button present.
            HStack {
                Button(action: { self.showAbout = true }) {
                    Text("About")
                }.sheet(isPresented: self.$showAbout) {
                    AboutView()
                }
                
                Toggle("Dark Mode", isOn: self.$darkModeSelected)
                
            }.padding([.horizontal, .top])
            #endif
            
            if gridNames.count > 0 {
                Picker("Colors:", selection: self.$gridIndex) {
                    ForEach(0 ..< self.gridNames.count) { index in
                        Text(self.gridNames[index]).tag(index)
                            .minimumScaleFactor(0.75)
                    }
                }.pickerStyle(self.pickerStyle())
            }
            
        }
    }
}

private extension GridHeaderView {
    /// Returns a `PickerStyle` suitable for styling the grid picker. watchOS doesn't suport `SegmentedPickerStyle` so we need a different style
    /// on that platform.
    /// - Returns: A `PickerStyle` that is correct for the the grid picker and the target platform.
    func pickerStyle() -> some PickerStyle {
        #if os(watchOS)
        return DefaultPickerStyle()
        #else
        return SegmentedPickerStyle()
        #endif
    }
}

struct GridHeader_Previews: PreviewProvider {
    static var previews: some View {
        GridHeaderView(darkModeSelected: .constant(false),
                       gridIndex: .constant(0),
                       gridNames: ["SwiftUI", "Fixed"])
    }
}

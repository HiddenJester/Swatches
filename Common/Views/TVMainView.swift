//
//  tvMainView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-01-06.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// This view is the main view for the app on tvOS. Instead of using a `GridHeader` it displays *all* of the grids, each in a single horizontal row.
/// grid below. It also sets the dark mode Bool to make the environment when it appears.
/// - Parameter gridModels: The grid models that can be displayed by this view.
struct TVMainView: View {
    /// Need to access the environment's color scheme in order to set the initial vlaue of `darkModeSelected`
    @Environment(\.colorScheme) var envScheme: ColorScheme
    
    /// These grid models will be display in rows.
    let gridModels: [GridModel]

    /// Storage for the dark mode Bool.
    @State private var darkModeSelected = false

    /// Storage for the selected Grid index. Note that TVMainView doesn't actually *have* grid selection,  but the `GridHeader` needs this around
    /// for simplicities sake.
    @State private var selectedGridIndex = 0

    /// The text to use as the sample for all of the swatches.
    @State private var textSample = "The quick brown fox jumps over the lazy dog."

    var body: some View {
        VStack {
            GridHeaderView(darkModeSelected: $darkModeSelected,
                           gridIndex: $selectedGridIndex,
                           gridNames: [String]())
            
            ScrollView {
                ForEach(gridModels) { gridModel in
                    Text(gridModel.name)
                        .font(.title)
                    
                    self.grid(models: gridModel.models)
                }
            }
            
        }.onAppear { self.darkModeSelected = (self.envScheme == .dark) } // Copy the environment value.
            .colorScheme(darkModeSelected ? .dark : .light) // Set the color scheme to the toggle value.
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
        
    }
}

private extension TVMainView {
    func grid(models: [SwatchModel] ) -> some View {
        let modelType = models.count > 0 ? type(of: models[0]) : nil
        let optimalColorWidth = CGFloat(300)

        if modelType == ColorModel.self {
            // Forced unwrap is fine here, we just checked the type above.
            let colorModels = models as! [ColorModel]
            return AnyView(
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(colorModels,id: \.self) { model in
                            FocusableView() {
                                ColorSwatchView(model: model, maxWidth: optimalColorWidth)
                            }
                        }
                    }.padding()
                    
                }
                
            )
        } else if modelType == TextModel.self {
            // Forced unwrap is fine here, we just checked the type above.
            let textModels = models as! [TextModel]
            return AnyView(
                VStack {
                    HStack {
                        Text("Sample:")
                            .font(.headline)
                            .padding()
                        
                        TextField("Sample Text:", text: self.$textSample)
                            .disableAutocorrection(true)
                            .padding()
                        
                    }.overlay(RoundedRectangle.init(cornerRadius: 20.0).stroke())
                        .padding()

                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            
                            ForEach(textModels,id: \.self) { model in
                                FocusableView(focusScale: 1.1) {
                                    TextSwatchView(sample: self.textSample, model: model)
                                    
                                }
                                
                            }
                            
                            Spacer()
                        }
                        
                    }
                    
                }.padding()

            )
        } else {
            return AnyView(HStack {
                FocusableView() {
                    Text("Missing Grid Type!")
                    
                }
                
            })
        }
    }
}

struct TVMainView_Previews: PreviewProvider {
    static let swiftUI = GridModel(name: "SwiftUI", models: ColorModel.swiftUIColors())
    static let textView =  GridModel(name: "Text", models: TextModel.textModels())
    static let adaptable = GridModel(name: "Adaptable", models: ColorModel.adaptableColors())
    
    static var previews: some View {
        Group {
            TVMainView(gridModels: [textView, swiftUI, adaptable])
            
            TVMainView(gridModels: [swiftUI, textView])
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
            
        }
    }
}


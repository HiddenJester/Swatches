//
//  tvMainView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-01-06.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// This view is the main view for the app on tvOS. Instead of using a `GridHeader` it displays *all* of the "grids", each in a single horizontal row.
/// It also sets the dark mode Bool to match the environment when it appears.
/// - Parameter gridModels: The grid models that can be displayed by this view.
struct TVMainView: View {
    /// Need to access the environment's color scheme in order to set the initial vlaue of `darkModeSelected`
    @Environment(\.colorScheme) var envScheme: ColorScheme
    
    /// These grid models will be display in rows.
    let gridModels: [GridModel]

    /// Storage for the dark mode Bool.
    @State private var darkModeSelected = false

    /// Storage for the selected Grid index. Note that `TVMainView` doesn't actually *have* grid selection,  but the `GridHeader` a binding for this.
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
                    
                    self.row(models: gridModel.models)
                }
            }
            
        }.onAppear { self.darkModeSelected = (self.envScheme == .dark) } // Copy the environment value.
            .colorScheme(darkModeSelected ? .dark : .light) // Set the color scheme to the toggle value.
            .animation(.default, value: darkModeSelected) // Animate the color scheme toggling.
        
    }
}

private extension TVMainView {
    /// Takes an array of models, determines the proper row type for those models and returns the row view.
    /// - Parameter models: An array of a single type of `SwatchModel` objects.
    /// - Returns: A horizontal scrollview that contains all of the swatches in a single row.
    /// - Note: There is some kerfuffling in the SwiftUI community about using `AnyView` for type erasure versus wrapping inside a `Group`. My current
    ///     understanding (see https://nalexn.github.io/anyview-vs-group/) is that it's a tempest in a teapot, so I'm using `AnyView` here.
    /// - Note: There's an assumption here that everything in `models` is the *same* type. Inspecting the various `FooModels` functions will
    ///     prove that this is the case, but if you really created some degenerate array this might break. Don't do that.
    func row(models: [SwatchModel] ) -> some View {
        /// Determines what type of models are stored in `models`. Used to type the content of the grids.
        let modelType = models.count > 0 ? type(of: models[0]) : nil

        if modelType == ColorModel.self {
            // Forced unwrap is fine here, we just checked the type above.
            return AnyView( colorRow(models: models as! [ColorModel]))
            
        } else if modelType == TextModel.self {
            // Forced unwrap is fine here, we just checked the type above.
            return AnyView(textRow(models: models as! [TextModel]))
            
        } else {
            return AnyView(FocusableView() { Text("Missing Row Type!") })
            
        }
    }
    
    /// Takes an array of `ColorModels` and returns a horizontally scrolling row of `ColorSwatchViews`.
    /// - Parameter models: The models to render.
    /// - Returns: a horizontally oriented `ScrollView` containing all of the `ColorSwatchViews`.
    func colorRow(models: [ColorModel]) -> some View {
        return ScrollView(.horizontal) {
            HStack {
                ForEach(models,id: \.self) { model in
                    FocusableView() {
                        ColorSwatchView(model: model)
                    }
                }
            }.padding()
            
        }
    }
    
    /// Takes an array of `TextModels` and returns a horizontally scrolling row of `TextSwatchViews`.
    /// - Parameter models: The models to render.
    /// - Returns: a horizontally oriented `ScrollView` containing all of the `TextSwatchViews`.
    func textRow(models: [TextModel]) -> some View {
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
                    
                    ForEach(models,id: \.self) { model in
                        FocusableView(focusScale: 1.1) {
                            TextSwatchView(sample: self.textSample, model: model)
                            
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
            
        }.padding()

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


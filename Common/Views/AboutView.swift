//
//  AboutView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-31.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment (\.presentationMode) var presentationMode

    @State private var showGist = false
    
    private let gistURL: URL = URL(string: "https://gist.github.com/HiddenJester/1a601bc5256dccaa0022bcd973a76c8b")!

    var body: some View {
        VStack {
            Text("About Swatches")
                .font(Font.title)
            
            Text("Swatches displays all of the colors defined in both SwiftUI and UIKit. There is an extension for SwiftUI.Color that maps all of the UIKit colors, allowing you to write code like:")
                .padding()
            
            CodeSampleView(text: "RoundedRectangle.backgroundColor(.systemGray4)")

            #if os(tvOS) // No web view for tvOS, just show the url in the link color.
            CodeSampleView(text: gistURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                .padding()
            #else // Provide a button that opens the gist in a SafariView.
            Button(action: { self.showGist.toggle() }) {
                CodeSampleView(text: gistURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
            }.padding(.vertical)
                .sheet(isPresented: self.$showGist) {
                    SafariView(url: self.gistURL)
            }
            #endif
            
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Dismiss")
            }.padding()
            
        }
    }
}



struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

//
//  AboutView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-31.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    /// This screen's presentation bool, manipulated by the Dismiss button.
    @Environment (\.presentationMode) var presentationMode

    /// A binding for whether the gist's webpage is showing.
    @State private var showGist = false
    
    /// A binding for whether the GitHub webpage is showing.
    @State private var showGitHub = false

    /// A binding for whether the HJS webpage is showing.
    @State private var showHJS = false

    /// The URL for the colors gist.
    private let gistURL =  URL(string: "https://gist.github.com/HiddenJester/1a601bc5256dccaa0022bcd973a76c8b")!

    /// The URL for the Swatches GitHub project.
    private let gitHubURL = URL(string: "https://github.com/HiddenJester/Swatches")!
    
    /// the URL for the main HJS webpage.
    private let hjsURL = URL(string: "https://www.hiddenjester.com")!
    
    var body: some View {
        VStack {
            ScrollView {
                Text("About Swatches")
                    .font(Font.title)
                
                Text("Swatches displays all of the colors defined in both SwiftUI and UIKit. There is an extension for SwiftUI.Color that maps all of the UIKit colors into SwiftUI, allowing you to write code like:")
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
                
                Text("The entire Swatches project is open source and the code is available on GitHub.")
                
                #if os(tvOS) // No web view for tvOS, just show the url in the link color.
                CodeSampleView(text: gitHubURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                    .padding()
                #else // Provide a button that opens GitHub in a SafariView.
                Button(action: { self.showGitHub.toggle() }) {
                    CodeSampleView(text: gitHubURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                }.padding(.vertical)
                    .sheet(isPresented: self.$showGitHub) {
                        SafariView(url: self.gitHubURL)
                }
                #endif

                Text("If you find this app useful, visit my site to see my occasional notes on development and check out my other applications!")
                
                #if os(tvOS) // No web view for tvOS, just show the url in the link color.
                CodeSampleView(text: hjsURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                    .padding()
                #else // Provide a button that opens HJS in a SafariView.
                Button(action: { self.showHJS.toggle() }) {
                    CodeSampleView(text: hjsURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                }.padding(.vertical)
                    .sheet(isPresented: self.$showHJS) {
                        SafariView(url: self.hjsURL)
                }
                #endif

            }

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

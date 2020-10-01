//
//  AboutView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-12-31.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A screen that provides the URLs for the Color extension gist, this (Swatches) project on GitHub, as well as the HJS main webpage. If the OS supports
/// a SFSafariView then the URLs will be clickable buttons.
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

    private let urlFont = Font.system(.footnote, design: .monospaced)

    var body: some View {
        VStack {
            Text("About Swatches")
                .font(Font.title)
                .padding()

            ScrollView {
                descriptionView()
                    .padding()

                gistView()
                    .padding()

                githubView()
                    .padding()

                hjsSiteView()
                    .padding()
            }

            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Dismiss")
            }

        }
    }
}

// MARK: Helper subviews
private extension AboutView {
    /// Decomposed subview that displays the description text at the top of the view.
    /// - Returns: the description subview.
    func descriptionView() -> some View {
        VStack {
            Text("Swatches displays all of the colors defined in both SwiftUI and UIKit. There is an extension for SwiftUI.Color that maps all of the UIKit colors into SwiftUI, allowing you to write code like:\n")

            CodeSampleView(text:
                            """
RoundedRectangle
    .backgroundColor(.systemGray4)
""")
        }
    }

    /// Decomposed subview that displays information about the gist, the URL, and a button to open the URL directly.
    /// - Returns: the gist subview.
    func gistView() -> some View {
        VStack {
            #if os(tvOS) // No web view for tvOS, just show the url in the link color.
            CodeSampleView(text: gistURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                .padding()
            #else // Provide a button that opens the gist in a SafariView.
            Button(action: { self.showGist.toggle() }) {
                Text("View the Color extension gist")
                    .foregroundColor(.link)
            }
            .sheet(isPresented: self.$showGist) { SafariView(url: self.gistURL) }

            Text(gistURL.absoluteString)
                .font(urlFont)
            #endif
        }
    }

    /// Decomposed subview that displays information about the GitHub repo, the URL, and a button to open the URL directly.
    /// - Returns: the GitHub subview.
    func githubView() -> some View {
        VStack {
            Text("The entire Swatches project is open source and the code is available on GitHub.\n")

            #if os(tvOS) // No web view for tvOS, just show the url in the link color.
            CodeSampleView(text: gitHubURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                .padding()
            #else // Provide a button that opens GitHub in a SafariView.
            Button(action: { self.showGitHub.toggle() }) {
                Text("View the Swatches GitHub")
            }
            .sheet(isPresented: self.$showGitHub) { SafariView(url: self.gitHubURL) }

            Text(gitHubURL.absoluteString)
                .font(urlFont)
            #endif
        }
    }

    /// Decomposed subview that displays information about the HJS site, the URL, and a button to open the URL directly.
    /// - Returns: the HJS site subview.
    func hjsSiteView() -> some View {
        VStack {
            Text("If you find this app useful, visit my site to see my occasional notes on development and check out my other applications!\n")

            #if os(tvOS) // No web view for tvOS, just show the url in the link color.
            CodeSampleView(text: hjsURL.absoluteString, foregroundColor: .link, backgroundColor: .clear)
                .padding()
            #else // Provide a button that opens HJS in a SafariView.
            Button(action: { self.showHJS.toggle() }) {
                Text("View the HiddenJester Software site")
            }
            .sheet(isPresented: self.$showHJS) {
                SafariView(url: self.hjsURL)
            }

            Text(hjsURL.absoluteString)
                .font(urlFont)
            #endif
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

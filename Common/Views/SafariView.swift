//
//  SafariView.swift
//  Swatches
//
//  Created by Timothy Sanders on 2020-01-06.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SafariServices.SFSafariViewController
import SwiftUI

/// Simple SwiftUI wrapper around a `SFSafariViewController`.
struct SafariView: UIViewControllerRepresentable {
    /// The URL to display.
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {
    }
    
}

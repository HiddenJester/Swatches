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

    private let bodyText =
    """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
"""
    var body: some View {
        VStack {
            Text("About Swatches")
                .font(Font.title)
            
            Spacer()
            
            Text(bodyText)
            
            Spacer()
            
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

//
//  CloserLabelToggle.swift
//  TodayTimer
//
//  Created by Timothy Sanders on 2020-07-09.
//  Copyright © 2020 HiddenJester Software. All rights reserved.
//

import SwiftUI

/// A wrapper around `Toggle` that doesn't allow the label all of the available space. It still provides the label *as a label* for accessibility, but hides it
/// via a `.labelsHidden()` modifier.  It also supports the `init` variants that takes a title string for the first argument, and the binding as the second.
struct CloserLabelToggle<Label>: View where Label : View {
    private let label: Label
    
    private let isOn: Binding<Bool>
    
    var body: some View {
        HStack {
            label
            
            Toggle(isOn: isOn) { label }
                .labelsHidden()
        }
    }
    
    public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self.isOn = isOn
        self.label = label()
    }
}

extension CloserLabelToggle where Label == Text {
    // Note that Toggle has a variant that takes a localized string key that I haven't reimplemented here yet.

    /// Creates an instance with a `Text` label generated from a title string.
    ///
    /// - Parameters:
    ///     - title: The title of `self`, describing its purpose.
    ///     - isOn: Whether `self` is "on" or "off".
    init<S>(_ title: S, isOn: Binding<Bool>) where S : StringProtocol {
        self = CloserLabelToggle(isOn: isOn) { Text(title) }
    }
}

struct CloserLabelToggle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CloserLabelToggle(isOn: .constant(true)) { Text("Testing Toggle") }
            
            CloserLabelToggle(isOn: .constant(true)) { Image(systemName: "trash.fill") }
            
            CloserLabelToggle("Testing Title Text", isOn: .constant(true))

        }.previewLayout(PreviewLayout.sizeThatFits)
    }
}

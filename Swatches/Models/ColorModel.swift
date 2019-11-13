//
//  ColorModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation
import SwiftUI

struct ColorModel {
    let id = UUID()
    
    let color: Color
    
    let name: String
}

extension ColorModel: Identifiable {}

//
//  GridModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-08.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

protocol SwatchModel {}

struct GridModel {
    let name: String
    
    let models: [SwatchModel]
}

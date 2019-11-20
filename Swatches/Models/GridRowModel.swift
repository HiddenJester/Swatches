//
//  SwatchGridRowModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

struct GridRowModel<Model: SwatchModel> {
    let id = UUID()
    
    let first: Model?
    
    let second: Model?
}

extension GridRowModel: Identifiable {}

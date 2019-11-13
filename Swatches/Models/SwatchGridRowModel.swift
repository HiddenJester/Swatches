//
//  SwatchGridRowModel.swift
//  Swatches
//
//  Created by Timothy Sanders on 2019-11-12.
//  Copyright © 2019 HiddenJester Software. All rights reserved.
//

import Foundation

struct SwatchGridRowModel {
    let id = UUID()
    
    let first: ColorModel
    
    let second: ColorModel?
}

extension SwatchGridRowModel: Identifiable {}

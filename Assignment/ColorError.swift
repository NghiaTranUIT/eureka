//
//  ColorError.swift
//  Assignment
//
//  Created by Nghia Tran on 10/20/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

enum ColorError: Error {

    case invalidHexColor
    case isEmpty
}

extension ColorError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .invalidHexColor:
            return "Invalid Hex Color"
        case .isEmpty:
            return "Text is empty"
        }
    }
}

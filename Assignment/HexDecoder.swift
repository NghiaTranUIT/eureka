//
//  HexDecoder.swift
//  Assignment
//
//  Created by Nghia Tran on 10/20/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import Cocoa

protocol HexDecoderType {

    func decode(_ hexStr: String) -> NSColor?
}

// MARK: - DefinedColor
enum DefinedColor: String {
    case white
    case red
    case brown
    case yellow
    case black
    case pink

    init?(_ rawValue: String) {
        switch rawValue {
        case DefinedColor.white.rawValue:
            self = DefinedColor.white
        case DefinedColor.red.rawValue:
            self = DefinedColor.red
        case DefinedColor.brown.rawValue:
            self = DefinedColor.brown
        case DefinedColor.yellow.rawValue:
            self = DefinedColor.yellow
        case DefinedColor.black.rawValue:
            self = DefinedColor.black
        case DefinedColor.pink.rawValue:
            self = DefinedColor.pink
        default:
            return nil
        }
    }

    var toColor: NSColor {
        switch self {
        case .black:
            return .black
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .pink:
            return .systemPink
        case .red:
            return .red
        case .white:
            return .white
        }
    }
}

// MARK: - HexDecoder
struct HexDecoder: HexDecoderType {

    // MARK: - Variable
    private let regex = NSRegularExpression("^#(?:[0-9a-fA-F]{3}){1,2}$")

    // MARK: - Public
    func decode(_ hexStr: String) -> NSColor? {

        // Check in defined list
        if let definedColor = DefinedColor(hexStr) {
            return definedColor.toColor
        }

        // Check Regex
        guard regex.matches(hexStr) else { return nil }
        return NSColor(hexString: hexStr)
    }
}

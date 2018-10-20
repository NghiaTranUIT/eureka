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

struct HexDecoder: HexDecoderType {

    let regex = NSRegularExpression("^#(?:[0-9a-fA-F]{3}){1,2}$")

    func decode(_ hexStr: String) -> NSColor? {
        guard regex.matches(hexStr) else { return nil }
        return NSColor(hexString: hexStr)
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

//
//  HexDecoderTests.swift
//  AssignmentTests
//
//  Created by Nghia Tran on 10/20/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import XCTest
@testable import Assignment

class HexDecoderTests: XCTestCase {

    private var hexDecoder: HexDecoder!

    override func setUp() {
        hexDecoder = HexDecoder()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecoderWithInvalidHexColor() {

        // Given
        let hex = "Toggl"

        // When
        let color = hexDecoder.decode(hex)

        // Then
        XCTAssertNil(color, "Toggle is invalid color")
    }

    func testDecoderWithValidHexColor() {
        // Given
        let hex = "#123123"
        let expectedColor = NSColor(hexString: hex)

        // When
        let color = hexDecoder.decode(hex)

        // Then
        XCTAssertNotNil(color, "#123123 is valid color")
        XCTAssertEqual(color, expectedColor)
    }

    func testDecoderWithDefinedText() {

        // Given
        let hex = "red"
        let expectedColor = NSColor.red

        // When
        let color = hexDecoder.decode(hex)

        // Then
        XCTAssertNotNil(color, "red is valid color")
        XCTAssertEqual(color, expectedColor)
    }

    func testDecoderWithUndefinedText() {

        // Given
        let hex = "gray"

        // When
        let color = hexDecoder.decode(hex)

        // Then
        XCTAssertNil(color, "gray is not defined color")
    }
}

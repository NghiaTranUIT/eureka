//
//  ViewModelsTests.swift
//  AssignmentTests
//
//  Created by Nghia Tran on 10/20/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import XCTest
import RxSwift
@testable import Assignment

class ViewModelsTests: XCTestCase {

    private var bag = DisposeBag()
    private var viewModel: ViewModel!

    override func setUp() {
        self.viewModel = ViewModel()
    }

    override func tearDown() {

    }

    func testEmptyTextShouldShowErrorAndDontShowPopup() {

        // Given
        let text = ""
        let input = ViewModel.Input(buttonTapObs: .just(text))

        // When
        let output = viewModel.transform(input)

        // Then
        output.errorObs.subscribe(onNext: { (error) in
            XCTAssertNotNil(error, "The text is empty")
            XCTAssertEqual(error!.localizedDescription, ColorError.isEmpty.localizedDescription, "Should be isEmpty")
        })
        .disposed(by: bag)

        output.popupObs.subscribe(onNext: { (text) in
            XCTFail("Shouldn't show the popup if the text is invalid")
        })
        .disposed(by: bag)
    }

    func testValidColorShouldShowPopupAndChangeColorAndHideErrorLabel() {

        // Given
        let text = "#FFFFFF"
        let expectedColor = NSColor(hexString: text)
        let input = ViewModel.Input(buttonTapObs: .just(text))

        // When
        let output = viewModel.transform(input)

        // Then
        output.errorObs.subscribe(onNext: { (error) in
            XCTAssertNil(error, "The error should be nil when it's valid color")
        })
        .disposed(by: bag)

        output.popupObs.subscribe(onNext: { (_text) in
            XCTAssertEqual(_text, text, "Popup should show the hex color")
        })
        .disposed(by: bag)

        output.textColor.subscribe(onNext: { (color) in
            XCTAssertEqual(color, expectedColor, "The color of text field should be changed")
        })
        .disposed(by: bag)
    }

    func testValidDefinedTextColorShouldShowPopupAndChangeColorAndHideErrorLabel() {

        // Given
        let text = "red"
        let expectedColor = NSColor.red
        let input = ViewModel.Input(buttonTapObs: .just(text))

        // When
        let output = viewModel.transform(input)

        // Then
        output.errorObs.subscribe(onNext: { (error) in
            XCTAssertNil(error, "The error should be nil when it's valid color")
        })
        .disposed(by: bag)

        output.popupObs.subscribe(onNext: { (_text) in
            XCTAssertEqual(_text, text, "Popup should show the red color")
        })
        .disposed(by: bag)

        output.textColor.subscribe(onNext: { (color) in
            XCTAssertEqual(color, expectedColor, "The color of text field should be changed")
        })
        .disposed(by: bag)
    }

    func testInvalidDefinedTextColorShouldNotShowPopupAndChangeColorButShowErrorLabel() {

        // Given
        let text = "gray"
        let expectedColor = NSColor.gray
        let input = ViewModel.Input(buttonTapObs: .just(text))

        // When
        let output = viewModel.transform(input)

        // Then
        output.errorObs.subscribe(onNext: { (error) in
            XCTAssertNotNil(error, "The text is not in defined list")
            XCTAssertEqual(error!.localizedDescription, ColorError.invalidHexColor.localizedDescription, "")
        })
        .disposed(by: bag)

        output.popupObs.subscribe(onNext: { (_text) in
            XCTFail("Shouldn't show the popup if the text is invalid")
        })
        .disposed(by: bag)

        output.textColor.subscribe(onNext: { (color) in
            XCTFail("Shouldn't show the popup if the text is invalid")
        })
        .disposed(by: bag)
    }
}

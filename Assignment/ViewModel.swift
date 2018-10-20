//
//  ViewModel.swift
//  Assignment
//
//  Created by Nghia Tran on 10/19/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}

// MARK: - ViewModel
final class ViewModel: ViewModelType {

    struct Input {
        let buttonTapObs: Observable<String?>
    }

    struct Output {
        let popupObs: Observable<String>
        let errorObs: Observable<Error?>
        let textColor: Observable<NSColor>
    }

    struct ColorPayload {
        let color: NSColor
        let hexString: String
    }

    private let hexDecoder: HexDecoderType

    init(hexDecoder: HexDecoderType = HexDecoder()) {
        self.hexDecoder = hexDecoder
    }

    // MARK: - Public

    // Transform the input to output stream
    // It's best practice I've learnt from Kickstart OSS
    func transform(_ input: ViewModel.Input) -> ViewModel.Output {

        // Convert the Text stream to Result<ColorPayload>
        // Result<ColorPayload> is convenience enum to determine if it's error or valid color
        let colorObs = input.buttonTapObs
            .map {[unowned self] (text) -> Result<ColorPayload> in

                // Whether text is empty or not
                guard let text = text, !text.isEmpty else {
                    return Result.error(ColorError.isEmpty)
                }

                // Whether text is valid color
                guard let color = self.hexDecoder.decode(text) else {
                    return Result.error(ColorError.invalidHexColor)
                }

                // Success
                return Result.success(ColorPayload(color: color, hexString: text))
            }
            .share() // Share the signal

        // errorObs
        // Convert the ColorObs to error
        // Error == nil => Hide the Error label
        // Error != nil => Show the error with human error
        let errorObs = colorObs
            .map { (result) -> Error? in
                guard result.isError else {
                    return nil
                }
                return result.error
            }

        // Text Signal
        let colorPayloadObs = colorObs
            .flatMap { (result) -> Observable<ColorPayload> in
                guard result.isSuccess else {
                    return .empty() // Stop the stream if it's error
                }
                return .just(result.value)
            }

        // Split the signal to each sub-signal
        let textObs = colorPayloadObs.map { $0.hexString }
        let textColorObs = colorPayloadObs.map { $0.color }

        // Output
        return Output(popupObs: textObs,
                      errorObs: errorObs,
                      textColor: textColorObs)
    }
}

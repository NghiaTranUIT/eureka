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

    func transform(_ input: ViewModel.Input) -> ViewModel.Output {

        let buttonObs = input.buttonTapObs

        let colorObs = buttonObs
            .map {[unowned self] (text) -> Result<ColorPayload> in
                guard let text = text, !text.isEmpty else {
                    return Result.error(ColorError.isEmpty)
                }
                guard let color = self.hexDecoder.decode(text) else {
                    return Result.error(ColorError.invalidHexColor)
                }
                return Result.success(ColorPayload(color: color, hexString: text))
            }
            .share()

        let errorObs = colorObs
            .map { (result) -> Error? in
                guard result.isError else {
                    return nil
                }
                return result.error
            }

        // Text Signal
        let colorPayloadObs = colorObs.flatMap { (result) -> Observable<ColorPayload> in
            guard result.isSuccess else {
                return .empty()
            }
            return .just(result.value)
        }

        let textObs = colorPayloadObs.map { $0.hexString }
        let textColorObs = colorPayloadObs.map { $0.color }

        return Output(popupObs: textObs,
                      errorObs: errorObs,
                      textColor: textColorObs)
    }
}

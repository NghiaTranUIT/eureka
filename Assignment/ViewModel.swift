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

final class ViewModel: ViewModelType {

    struct Input {

        let buttonTabObs: Observable<String?>
    }

    struct Output {
        let popupObs: Observable<String>
        let errorObs: Observable<Bool>
    }

    func transform(_ input: ViewModel.Input) -> ViewModel.Output {

        let buttonObs = input.buttonTabObs.share()

        let errorObs = buttonObs.map { text -> Bool in
            guard let text = text, !text.isEmpty else {
                return false
            }
            return true

        }

        let textObs = buttonObs.flatMap { (text) -> Observable<String> in
            guard let text = text, !text.isEmpty else {
                return .empty()
            }

            return .just(text)

        }

        return Output(popupObs: textObs, errorObs: errorObs)
    }
}

//
//  ViewController.swift
//  Assignment
//
//  Created by Nghia Tran on 10/19/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

final class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var button: NSButton!
    @IBOutlet weak var errorTextField: NSTextField!

    private let bag = DisposeBag()
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        binding()
    }

    private func binding() {

        // Get latest value from TextField when the button is tapped
        let tapObs = button.rx.tap
            .asObservable()
            .withLatestFrom(textField.rx.text)

        // Init the input stream
        let input = ViewModel.Input(buttonTapObs: tapObs)

        // Then we transform
        let output = viewModel.transform(input)

        // Show Popup
        output.popupObs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (text) in
                guard let strongSelf = self else { return }
                strongSelf.presentPopUp(text)
            })
            .disposed(by: bag)

        // Error
        output.errorObs
            .observeOn(MainScheduler.instance)
            .bind(to: errorTextField.rx.isHidden)
            .disposed(by: bag)
    }

    private func presentPopUp(_ text: String) {
        print("Show pop \(text)")
    }

}


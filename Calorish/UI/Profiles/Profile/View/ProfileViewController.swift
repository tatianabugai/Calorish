//
//  ProfileViewController.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func updateView(with viewModel: ProfileViewModel)
    func setDoneButtonEnabled(_ isEnabled: Bool)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    var interactor: ProfileBusinessLogic?
    
    @IBOutlet private var nameTextFieldView: TextFieldView!
    @IBOutlet private var kcalTextFieldView: TextFieldView!
    @IBOutlet private var kcalLabel: UILabel!
    
    private lazy var doneButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.commonDone(),
                                                       style: .done,
                                                       target: self,
                                                               action: #selector(didTapDoneButton))
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.commonCancel(),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(didTapCancelButton))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton

        view.backgroundColor = .systemGray6
        
        nameTextFieldView.addTarget(self, action: #selector(nameChanged(_:)), controlEvent: .editingChanged)
        nameTextFieldView.keyboardType = .default
        
        kcalTextFieldView.addTarget(self, action: #selector(kcalChanged(_:)), controlEvent: .editingChanged)
        kcalTextFieldView.keyboardType = .numberPad

        kcalLabel.text = R.string.localizable.unitKcalShort()
        
        interactor?.didTriggerViewReadyEvent()
    }
    
    @objc private func didTapDoneButton() {
        interactor?.didTapDoneButton()
    }
    
    @objc private func didTapCancelButton() {
        interactor?.didTapCancelButton()
    }
    
    @objc private func nameChanged(_ textField: UITextField) {
        interactor?.didTriggerNameChangedEvent(textField.text ?? "")
    }
    
    @objc private func kcalChanged(_ textField: UITextField) {
        interactor?.didTriggerKcalChangedEvent(textField.text ?? "")
    }
    
    func updateView(with viewModel: ProfileViewModel) {
        title = viewModel.title
        
        nameTextFieldView.setup(with: viewModel.name)
        kcalTextFieldView.setup(with: viewModel.kcal)
    }
    
    func setDoneButtonEnabled(_ isEnabled: Bool) {
        doneButton.isEnabled = isEnabled
    }
}

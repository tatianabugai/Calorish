//
//  FoodViewController.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol FoodDisplayLogic: AnyObject {
    func updateView(with viewModel: FoodViewModel)
    func setDoneButtonEnabled(_ isEnabled: Bool)
    func setKcalLabel(with text: String, isValid: Bool)
}

class FoodViewController: UIViewController, FoodDisplayLogic {
    
    var interactor: FoodBusinessLogic?
    
    @IBOutlet private var nameTextFieldView: TextFieldView!
    @IBOutlet private var proteinsTextFieldView: TextFieldView!
    @IBOutlet private var carbsTextFieldView: TextFieldView!
    @IBOutlet private var fatTextFieldView: TextFieldView!

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
        
        proteinsTextFieldView.addTarget(self, action: #selector(proteinsChanged(_:)), controlEvent: .editingChanged)
        proteinsTextFieldView.keyboardType = .numberPad
        
        carbsTextFieldView.addTarget(self, action: #selector(carbsChanged(_:)), controlEvent: .editingChanged)
        carbsTextFieldView.keyboardType = .numberPad
        
        fatTextFieldView.addTarget(self, action: #selector(fatChanged(_:)), controlEvent: .editingChanged)
        fatTextFieldView.keyboardType = .numberPad

        kcalLabel.text = "0 " + R.string.localizable.unitKcalShort()
        
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
    
    @objc private func proteinsChanged(_ textField: UITextField) {
        interactor?.didTriggerProteinsChangedEvent(textField.text ?? "")
    }
    
    @objc private func carbsChanged(_ textField: UITextField) {
        interactor?.didTriggerCarbsChangedEvent(textField.text ?? "")
    }
    
    @objc private func fatChanged(_ textField: UITextField) {
        interactor?.didTriggerFatChangedEvent(textField.text ?? "")
    }
    
    func updateView(with viewModel: FoodViewModel) {
        title = viewModel.title
        
        nameTextFieldView.setup(with: viewModel.name)
        proteinsTextFieldView.setup(with: viewModel.proteins)
        carbsTextFieldView.setup(with: viewModel.carbs)
        fatTextFieldView.setup(with: viewModel.fat)
        kcalLabel.text = String(viewModel.kcal.text)
    }
    
    func setDoneButtonEnabled(_ isEnabled: Bool) {
        doneButton.isEnabled = isEnabled
    }
    
    func setKcalLabel(with text: String, isValid: Bool) {
        kcalLabel.text = text
        kcalLabel.textColor = isValid ? .label : .red
    }
}

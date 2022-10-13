//
//  IntakeViewController.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol IntakeDisplayLogic: AnyObject {
    func updateView(with viewModel: IntakeViewModel)
    func setDoneButtonEnabled(_ isEnabled: Bool)
}

class IntakeViewController: UIViewController, IntakeDisplayLogic {
    
    var interactor: IntakeBusinessLogic?
    
    @IBOutlet private var foodButton: UIButton!
    @IBOutlet private var weightTextField: TextFieldView!
    @IBOutlet private var weightUnitLabel: UILabel!    
    
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
        
        foodButton.setTitle(R.string.localizable.foodButtonTitle(), for: .normal)
        foodButton.tintColor = .systemBlue
        foodButton.addTarget(self, action: #selector(didTapItemButton), for: .touchUpInside)
        
        weightTextField.addTarget(self, action:  #selector(weightChanged(_:)), controlEvent: .editingChanged)
        weightUnitLabel.text = R.string.localizable.unitGrams()
        
        interactor?.didTriggerViewReadyEvent()
    }
    
    @objc private func didTapDoneButton() {
        interactor?.didTapDoneButton()
    }
    
    @objc private func didTapCancelButton() {
        interactor?.didTapCancelButton()
    }
    
    @objc private func didTapItemButton() {
        interactor?.didTapItemButton()
    }
    
    @objc private func weightChanged(_ textField: UITextField) {
        interactor?.didTriggerWeightChangedEvent(textField.text ?? "")
    }
   
    func updateView(with viewModel: IntakeViewModel) {
        title = viewModel.title
        foodButton.setTitle(viewModel.food.isDefined ? viewModel.food.name : viewModel.food.placeholder,
                            for: .normal)
        weightTextField.setup(with: viewModel.weight)
    }
    
    func setDoneButtonEnabled(_ isEnabled: Bool) {
        doneButton.isEnabled = isEnabled
    }
}

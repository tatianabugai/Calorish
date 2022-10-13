//
//  IntakePresenter.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol IntakePresentationLogic {
    func presentIntake(intake: Intake, mode: IntakeMode)
    func presentDoneButtonEnabled(_ isEnabled: Bool)
}

class IntakePresenter: IntakePresentationLogic {
    weak var viewController: IntakeDisplayLogic?
    
    func presentIntake(intake: Intake, mode: IntakeMode) {
        
        let foodViewModel = IntakeViewModel.Food(name: intake.item?.name ?? "",
                                                 placeholder: R.string.localizable.foodButtonTitle(),
                                                 isDefined: intake.item != nil)
        
        let weightViewModel = IntakeViewModel.Weight(text: String(intake.grams ?? 0),
                                                     placeholder: R.string.localizable.weight())
                
        let viewModel = IntakeViewModel(title: mode.title(for: intake.type),
                                        food: foodViewModel,
                                        weight: weightViewModel)
        
        viewController?.updateView(with: viewModel)
    }
    
    func presentDoneButtonEnabled(_ isEnabled: Bool) {
        viewController?.setDoneButtonEnabled(isEnabled)
    }
}

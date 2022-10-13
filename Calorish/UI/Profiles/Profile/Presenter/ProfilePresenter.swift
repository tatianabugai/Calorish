//
//  ProfilePresenter.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentProfile(fields: ProfileFields, mode: ProfileMode)
    func presentDoneButtonEnabled(_ isEnabled: Bool)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?
    
    func presentProfile(fields: ProfileFields, mode: ProfileMode) {
        
        let nameViewModel = ProfileViewModel.Name(
            text: fields.name.text,
            placeholder: R.string.localizable.commonName())
        
        let kcalViewModel = ProfileViewModel.Kcal(
            text: fields.kcal.text,
            placeholder: "0")
                
        let viewModel = ProfileViewModel(title: mode.title,
                                         name: nameViewModel,
                                         kcal: kcalViewModel)
        
        viewController?.updateView(with: viewModel)
    }
    
    func presentDoneButtonEnabled(_ isEnabled: Bool) {
        viewController?.setDoneButtonEnabled(isEnabled)
    }
}

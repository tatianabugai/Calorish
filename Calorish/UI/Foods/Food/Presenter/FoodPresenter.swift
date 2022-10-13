//
//  FoodPresenter.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

protocol FoodPresentationLogic {
    func presentFood(fields: FoodFields, mode: FoodMode)
    func presentDoneButtonEnabled(_ isEnabled: Bool)
    func presentKcal(_ kcal: FoodFields.Kcal)
}

class FoodPresenter: FoodPresentationLogic {
    weak var viewController: FoodDisplayLogic?
    
    func presentFood(fields: FoodFields, mode: FoodMode) {
        
        let nameViewModel = FoodViewModel.Name(text: fields.name.text,
                                               placeholder: R.string.localizable.commonName())
        
        let proteinsViewModel = FoodViewModel.Nutrient(text: fields.proteins.text,
                                                       placeholder: "0")
        
        let carbsViewModel = FoodViewModel.Nutrient(text: fields.carbs.text,
                                                    placeholder: "0")
        
        let fatViewModel = FoodViewModel.Nutrient(text: fields.fat.text,
                                                  placeholder: "0")
        
        let kcalViewModel = FoodViewModel.Kcal(text: kcalString(from: fields.kcal.value),
                                               isValid: fields.kcal.isValid)
                
        let viewModel = FoodViewModel(title: mode.title,
                                      name: nameViewModel,
                                      proteins: proteinsViewModel,
                                      carbs: carbsViewModel,
                                      fat: fatViewModel,
                                      kcal: kcalViewModel)
        
        viewController?.updateView(with: viewModel)
    }
    
    func presentDoneButtonEnabled(_ isEnabled: Bool) {
        viewController?.setDoneButtonEnabled(isEnabled)
    }
    
    func presentKcal(_ kcal: FoodFields.Kcal) {
        viewController?.setKcalLabel(with: kcalString(from: kcal.value), isValid: kcal.isValid)
    }
    
    private func kcalString(from kcalInt: Int) -> String {
        return String(kcalInt) + " Ккал. на 100 г."
    }
}

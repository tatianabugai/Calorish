//
//  RecipesPresenter.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

protocol RecipePresentationLogic {
    
    func presentTitle(with title: String)
    func presentDoneButtonEnabled(_ isEnabled: Bool)
    func presentRecipe(model: RecipeModel, mode: RecipeMode)
}

class RecipePresenter: RecipePresentationLogic {
    
    weak var viewController: RecipeDisplayLogic?
    
    func presentRecipe(model: RecipeModel, mode: RecipeMode) {
        
        let header = headerViewModel(from: model)
        
        let table = tableViewModel(from: model.ingredients)
                
        let viewModel = RecipeViewModel(title: mode.title,
                                        header: header,
                                        table: table)
        
        viewController?.setView(with: viewModel)
    }
    
    func presentDoneButtonEnabled(_ isEnabled: Bool) {
        viewController?.setDoneButtonEnabled(isEnabled)
    }
    
    func presentTitle(with title: String) {
        viewController?.setTitle(with: title)
    }
    
    private func headerViewModel(from model: RecipeModel) -> RecipeHeaderViewModel {
        
        let nameViewModel = RecipeHeaderViewModel.Name(text: model.name.text,
                                                       placeholder:  R.string.localizable.commonName())
        
        
        let kcal = String(model.kcal) + " " + Constants.kcalShort + " " + R.string.localizable.perHundredGram()
        
        let nutrients = "\(Constants.protShort): \(model.proteins)  \(Constants.fatShort): \(model.fat)  \(Constants.carbShort): \(model.carbs)"
        
        return RecipeHeaderViewModel(name: nameViewModel,
                                     kcal: kcal,
                                     nutrients: nutrients,
                                     ingredientsTitle: R.string.localizable.ingredients())
    }
    
    private func tableViewModel(from ingredients: [RecipeModel.Ingredient]) -> RecipeTableViewModel {
        
        let cells = ingredients.map { $0.viewModel }
        
        let section = RecipeTableViewModel.Section(section: "",
                                                   cells: cells)
        
        return RecipeTableViewModel(sections: [section])
    }
}

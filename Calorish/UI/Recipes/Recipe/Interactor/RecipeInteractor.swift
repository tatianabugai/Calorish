//
//  RecipesInteractor.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol RecipeBusinessLogic {
    
    func didTriggerViewReadyEvent()
    func didTapDoneButton()
    func didTapAddButton()
    func didTapCancelButton()
    func didTriggerNameChangedEvent(_ name: String)
    
    func didSelectRow(at indexPath: IndexPath)
}

class RecipeInteractor: RecipeBusinessLogic, RecipeInput {
    
    var presenter: RecipePresentationLogic?
    var router: (NSObjectProtocol & RecipeRoutingLogic)?
    
    private var model: RecipeModel = RecipeModel()
    
    var recipe: Recipe?
    var mode: RecipeMode = .edit
    
    func configure(recipe: Recipe?, mode: RecipeMode) {
        self.recipe = recipe
        self.mode = mode
        
        switch mode {
        case .edit:
            guard let recipe = recipe else { break }
            setupModelWith(recipe)
            
        case .create:
            setModelEmpty()
        }
    }
    
    func didTriggerViewReadyEvent() {
        presenter?.presentRecipe(model: model, mode: mode)
        presenter?.presentDoneButtonEnabled(model.isValid)
        presenter?.presentTitle(with: R.string.localizable.newRecipe())
    }
    
    func didTapDoneButton() {
        switch mode {
        case .edit:
            updateRecipe(matching: model)
        case .create:
            createRecipe(matching: model)
        }
        router?.close(transitionType: .dismiss)
    }
    
    func didTapAddButton() {
        router?.openIntake(Intake(emptyOfType: .ingredient), mode: .create, output: self)
    }
    
    func didTapCancelButton() {
        router?.close(transitionType: .dismiss)
    }
    
    func didTriggerNameChangedEvent(_ name: String) {
        model.name.text = name
        presenter?.presentDoneButtonEnabled(model.isValid)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
    
    private func createRecipe(matching model: RecipeModel) {
        
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                
                let recipe = transaction.create(Into<Recipe>())
                recipe.name = model.name.text
                
                self?.createRecipeIngredients(from: model, for: recipe, in: transaction)
                
                let item = transaction.create(Into<Item>())
                item.isCreatedByUser = true
                item.lastTimeUsedAt = Date()
                item.name = recipe.name
                item.typeRawValue = Item.ItemType.recipe.rawValue
                item.recipe = recipe
            },
            completion: { _ in }
        )
    }
    
    private func updateRecipe(matching model: RecipeModel) {
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                
                guard let self = self,
                      let recipe = transaction.edit(self.recipe),
                      let item = transaction.edit(recipe.item) else { return }
                
                recipe.name = self.model.name.text
 
                self.createRecipeIngredients(from: model, for: recipe, in: transaction)
                
                item.name = recipe.name
                item.lastTimeUsedAt = Date()
            },
            completion: { _ in }
        )
    }
    
    private func createRecipeIngredients(from model: RecipeModel, for recipe: Recipe, in transaction: AsynchronousDataTransaction) {
        
        for ingredientModel in model.ingredients.filter { !$0.isSaved } {
            
            guard let item = transaction.edit(ingredientModel.item) else { fatalError() }
            
            let ingredient = transaction.create(Into<Ingredient>())
            
            ingredient.item = item
            ingredient.id = ingredientModel.id
            ingredient.grams = Int16(ingredientModel.grams)
            ingredient.recipe = recipe
        }
    }
    
    private func setupModelWith(_ recipe: Recipe) {
        
        model.name.text = recipe.name ?? ""
        
        let ingredients = recipe.ingredients?.allObjects as! [Ingredient]
        let ingredientModels = ingredients.map { $0.model }
        
        model.ingredients = ingredientModels
    }
    
    private func setModelEmpty() {
        model = RecipeModel()
    }
}
extension RecipeInteractor: IntakeOutput {
    
    func didTriggerIntakeChanged(intake: Intake) {
        
        updateIngredient(matching: intake)
        presenter?.presentRecipe(model: model, mode: mode)
    }
    
    func didTriggerIntakeCreated(intake: Intake) {
        
        createIngredient(matching: intake)
        presenter?.presentRecipe(model: model, mode: mode)
    }
    
    private func updateIngredient(matching intake: Intake) {
        for (index, ingredient) in model.ingredients.enumerated() {
            if ingredient.id == intake.id {
                model.ingredients[index].update(with: intake)
            }
        }
    }
    
    private func createIngredient(matching intake: Intake) {
        let ingredient = RecipeModel.Ingredient(intake: intake)
        model.ingredients.append(ingredient)
    }    
}

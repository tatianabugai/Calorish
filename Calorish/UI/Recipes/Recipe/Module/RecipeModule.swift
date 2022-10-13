//
//  RecipesModule.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
protocol RecipeInput {
    var recipe: Recipe? { get set }
    var mode: RecipeMode { get set }
    func configure(recipe: Recipe?, mode: RecipeMode)
}

class RecipeModule {
    
    var input: RecipeInput {
        return interactor
    }
    
    let viewController: RecipeViewController
    let interactor: RecipeInteractor
    let presenter: RecipePresenter
    let router: RecipeRouter
    
    init() {
        let router = RecipeRouter()
        let presenter = RecipePresenter()
        let interactor = RecipeInteractor()
        guard let viewController = R.storyboard.recipe.recipeViewController() else {
            fatalError("R.swift should return valid view controller")
        }
        
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        self.router = router
        self.viewController = viewController
        self.presenter = presenter
        self.interactor = interactor
    }
}


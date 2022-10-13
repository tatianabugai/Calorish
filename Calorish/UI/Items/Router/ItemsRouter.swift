//
//  FoodsRouter.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ItemsRoutingLogic: Closable {
    func openFood(food: Food?, mode: FoodMode)
    func openRecipe(recipe: Recipe?, mode: RecipeMode)
}

class ItemsRouter: Router<ItemsViewController>, ItemsRoutingLogic {
        
    func openFood(food: Food?, mode: FoodMode) {

        let module = FoodModule()
        module.input.configure(food: food, mode: mode)

        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
    
    func openRecipe(recipe: Recipe?, mode: RecipeMode) {

        let module = RecipeModule()
        module.input.configure(recipe: recipe, mode: mode)

        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}

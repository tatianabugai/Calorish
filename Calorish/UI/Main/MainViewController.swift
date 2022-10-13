//
//  MainViewController.swift
//  Calorish
//
//  Created by admin on 23.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profiles = ProfilesModule()
        let meals = MealsModule()
        
        let foods = ItemsModule()
        foods.input.configure(mode: .present, type: .foods)
        
        let recipes = ItemsModule()
        recipes.input.configure(mode: .present, type: .recipes)
        
        let navProfiles = NavigationController(rootViewController: profiles.viewController)
        let navMeals = NavigationController(rootViewController: meals.viewController)
        let navFoods = NavigationController(rootViewController: foods.viewController)
        let navRecipes = NavigationController(rootViewController: recipes.viewController)
        
        navProfiles.tabBarItem = UITabBarItem(title: R.string.localizable.tabProfiles(),
                                              image: UIImage.profilesTab,
                                              selectedImage: nil)
        
        navMeals.tabBarItem = UITabBarItem(title: R.string.localizable.tabMeals(),
                                           image: UIImage.mealsTab,
                                           selectedImage: nil)
        
        navFoods.tabBarItem = UITabBarItem(title: R.string.localizable.tabFoods(),
                                           image: UIImage.foodsTab,
                                           selectedImage: nil)
        
        navRecipes.tabBarItem = UITabBarItem(title: R.string.localizable.tabRecipes(),
                                             image: UIImage.recipesTab,
                                             selectedImage: nil)
        
        let viewControllers = [navMeals,
                               navFoods,
                               navRecipes,
                               navProfiles]
        
        setViewControllers(viewControllers, animated: true)
        
      
    }
}

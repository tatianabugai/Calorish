//
//  RecipeViewModel.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

typealias RecipeTableViewModel = TableViewModel<String, MealCellViewModel>

struct RecipeViewModel {
    
    let title: String
    let header: RecipeHeaderViewModel
    let table: RecipeTableViewModel
    
}

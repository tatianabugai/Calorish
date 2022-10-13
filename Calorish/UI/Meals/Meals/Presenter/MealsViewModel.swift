//
//  MealsViewModel.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

typealias MealsTableViewModel = TableViewModel<MealSectionViewModel, MealCellViewModel>

struct MealsViewModel {
    
    let profileName: String
    let header: MealsHeaderViewModel
    let table: MealsTableViewModel
}
    
// TODO: - move to section view
struct MealSectionViewModel {
    var name: String
    var time: String
    var nutrients: String
    var kcal: String
}

//
//  MealsGroup.swift
//  Calorish
//
//  Created by admin on 08.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

class MealGroup {
    
    init(meals: [Meal], time: Date) {
        self.meals = meals.sorted { $0.id < $1.id }
        self.time = time
    }
    
    var meals: [Meal]
    var time: Date
    
    private var kcal: Int {
        return meals.map { $0.kcal }.reduce(0, +)
    }
    
    var viewModel: MealSectionViewModel {
        return MealSectionViewModel(name: "1",
                                    time: time.description,
                                    nutrients: "1",
                                    kcal: "1")
    }
}

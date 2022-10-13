//
//  FoodViewModel.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct FoodViewModel {
    
    let title: String
    
    let name: Name
    let proteins: Nutrient
    let carbs: Nutrient
    let fat: Nutrient
    let kcal: Kcal
    
    struct Name: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
    
    struct Nutrient: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
    
    struct Kcal {
        let text: String
        let isValid: Bool
    }
}

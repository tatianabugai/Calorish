//
//  FoodFields.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct FoodFields {
    
    var name: Name
    
    var proteins: Nutrient    
    var carbs: Nutrient
    var fat: Nutrient
    
    var kcal: Kcal {
        return calculateKcal(proteins: proteins, carbs: carbs, fat: fat)
    }
    
    var isValid: Bool {
        return name.isValid && proteins.isValid && carbs.isValid && fat.isValid && kcal.isValid
    }
    
    init(name: Name = Name(), proteins: Nutrient = Nutrient(), carbs: Nutrient = Nutrient(), fat: Nutrient = Nutrient()) {
        self.name = name
        self.proteins = proteins
        self.carbs = carbs
        self.fat = fat
    }
    
    struct Name: TextField {
        var text: String = ""
    }
    
    struct Nutrient: NumericField {
        var text: String = ""
    }
    
    struct Kcal {
        
        var value: Int = 0
        
        var isValid: Bool {
            value <= 1000
        }
    }
    
    private func calculateKcal(proteins: Nutrient, carbs: Nutrient, fat: Nutrient) -> Kcal {
        let proteinKcalPerGram = 4
        let carbKcalPerGram = 4
        let fatKcalPerGram = 9
        
        let proteins = Int(proteins.text) ?? 0
        let carbs = Int(carbs.text) ?? 0
        let fat = Int(fat.text) ?? 0

        let kcal = Int(proteins * proteinKcalPerGram + carbs * carbKcalPerGram + fat * fatKcalPerGram)
        return Kcal(value: kcal)
    }
}

//
//  Meal+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 19.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData

@objc(Meal)
class Meal: NSManagedObject {
    
    var proteins: Double {
        guard let item = item else { return 0 }
        return Double(grams) * item.proteins / 100
    }
    
    var fat: Double {
        guard let item = item else { return 0 }
        return Double(grams) * item.fat / 100
    }
    
    var carbs: Double {
        guard let item = item else { return 0 }
        return Double(grams) * item.carbs / 100
    }
    
    var kcal: Int {
        return Int(proteins * 4 + carbs * 4 + fat * 9)
    }

    var viewModel: MealCellViewModel {
        
        let nutrients: String = {
            
            guard let proteins = item?.proteins,
                  let carbs = item?.carbs,
                  let fat = item?.fat else { fatalError() }
            
            let totalProteins = Double(proteins * Double(grams) / 100).rounded()
            let totalFat = Double(fat * Double(grams) / 100).rounded()
            let totalCarbs = Double(carbs * Double(grams) / 100).rounded()
            
            return "Б: \(totalProteins)  Ж: \(totalFat)  У: \(totalCarbs)"
        }()
        
        return MealCellViewModel(name: item?.name ?? "",
                                 nutrients: nutrients,
                                 kcal: String(kcal) + " к  " + String(grams) + " г")
    }
}


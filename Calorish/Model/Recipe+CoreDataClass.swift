//
//  Recipe+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 09.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData

@objc(Recipe)
class Recipe: NSManagedObject {
    
    var proteins: Double {
        return (ingredients?.allObjects as! [Ingredient]).map { (ingredient) in
            guard let item = ingredient.item else { fatalError() }
            return item.proteins * Double(ingredient.grams) / 100
        }.reduce(0, +)
    }
    
    var fat: Double {
        return (ingredients?.allObjects as! [Ingredient]).map { (ingredient) in
            guard let item = ingredient.item else { fatalError() }
            return item.fat * Double(ingredient.grams) / 100
        }.reduce(0, +)
    }
    
    var carbs: Double {
        return (ingredients?.allObjects as! [Ingredient]).map { (ingredient) in
            guard let item = ingredient.item else { fatalError() }
            return item.carbs * Double(ingredient.grams) / 100
        }.reduce(0, +)
    }
    
    var kcal: Int16 {
        return Int16(proteins * 4 + carbs * 4 + fat * 9)
    }
}

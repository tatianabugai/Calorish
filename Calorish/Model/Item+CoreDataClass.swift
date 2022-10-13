//
//  Item+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 09.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData

// This object is used for merge Food and Recipe data in one list
// for convenient usage on Foods screen.

@objc(Item)
class Item: NSManagedObject {
    
    enum ItemType: Int16 {
        case food
        case recipe
        case unknown
    }
    
    private var type: ItemType {
        return ItemType(rawValue: typeRawValue) ?? .unknown
    }
    
    var kcal: Int16 {
        switch type {
        case .food:
            return food?.kcal ?? 0
        case .recipe:
            return recipe?.kcal ?? 0
        case .unknown:
            return 0
        }
    }
    
    var proteins: Double {
        switch type {
        case .food:
            return food?.proteins ?? 0
        case .recipe:
            return recipe?.proteins ?? 0
        case .unknown:
            return 0
        }
    }
    
    var carbs: Double {
        switch type {
        case .food:
            return food?.carbs ?? 0
        case .recipe:
            return recipe?.carbs ?? 0
        case .unknown:
            return 0
        }
    }
    
    var fat: Double {
        switch type {
        case .food:
            return food?.fat ?? 0
        case .recipe:
            return recipe?.fat ?? 0
        case .unknown:
            return 0
        }
    }
    
    var id: UUID {
        switch type {
        case .food:
            guard let food = food,
                  let id = food.id else { fatalError() }
            return id
        case .recipe:
            guard let recipe = recipe,
                  let id = recipe.id else { fatalError() }
            return id
        case .unknown:
            fatalError()
        }
    }
    
    func viewModel() -> ItemCellViewModel {
        
        return ItemCellViewModel(name: name ?? "",
                                 kcal: String(kcal),
                                 proteinsGrams: String(proteins),
                                 carbsGrams: String(carbs),
                                 fatGrams: String(fat))
    }
}

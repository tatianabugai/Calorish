//
//  Ingredient+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 09.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData

@objc(Ingredient)
class Ingredient: NSManagedObject {
    
    var model: RecipeModel.Ingredient {
        
        guard let id = id,
              let item = item else { fatalError() }
        
        return RecipeModel.Ingredient(id: id,
                                      grams: Int(grams),
                                      item: item,
                                      isSaved: true)
    }
}

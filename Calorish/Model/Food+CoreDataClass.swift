//
//  Food+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 24.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData

@objc(Food)
class Food: NSManagedObject {
    
    var kcal: Int16 {
        return Int16(proteins * 4 + carbs * 4 + fat * 9)
    }
}


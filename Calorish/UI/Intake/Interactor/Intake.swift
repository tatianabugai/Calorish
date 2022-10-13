//
//  Intake.swift
//  Calorish
//
//  Created by admin on 16.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct Intake {
    
    enum IntakeType {
        case meal
        case ingredient
        case unknown
    }
    
    let id: UUID
    let type: IntakeType
    var time: Date?
    var grams: Int?
    var item: Item?
    
    // FIX: - не оч удачный вариант. можно создавать просто nil, но тогда нужно выносить type как отдельную переменную интерактора типа как mode 
    init(emptyOfType type: IntakeType) {
        self.id = UUID()
        self.type = type
        self.time = nil
        self.grams = nil
        self.item = nil
    }
    
    init(meal: Meal) {
        guard let id = meal.id else { fatalError() }
        self.time = meal.time
        self.grams = Int(meal.grams)
        self.id = id
        self.item = meal.item
        self.type = .meal
    }
    
    init(ingredient: Ingredient) {
        guard let id = ingredient.id else { fatalError() }
        self.grams = Int(ingredient.grams)
        self.id = id
        self.item = ingredient.item
        self.time = nil
        self.type = .ingredient
    }
    
    mutating func update(with fields: IntakeFields) {
        grams = Int(fields.weight.text) ?? 0
    }
}

//
//  RecipeFields.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct RecipeModel {
    
    var name: Name
    var proteins: Double { return calculateProteins(from: ingredients) }
    var carbs: Double { return calculateCarbs(from: ingredients) }
    var fat: Double { return calculateFat(from: ingredients) }
    var kcal: Int { return calculateKcal(proteins: proteins, carbs: carbs, fat: fat) }
    var isValid: Bool { return name.isValid && ingredients.count > 0 }
    var ingredients: [Ingredient]
    
    init(name: Name = Name(), ingredients: [Ingredient] = []) {
        self.name = name
        self.ingredients = ingredients
    }
    
    struct Name: TextField {
        var text: String = ""
    }
    
    struct Ingredient {
        
        var id: UUID
        var grams: Int
        var item: Item
        var isSaved: Bool
        
        var viewModel: MealCellViewModel {           

            let nutrients = "\(Constants.protShort): \(item.proteins)  \(Constants.fatShort): \(item.fat)  \(Constants.carbShort): \(item.carbs)"

            let kcal = String(item.kcal) + " " + Constants.kcalShort + "  " + String(grams) + "  " + Constants.gramShort
            
            return MealCellViewModel(name: item.name ?? "",
                                     nutrients: nutrients,
                                     kcal: kcal)
        }
        
        init(id: UUID, grams: Int, item: Item, isSaved: Bool) {
            self.id = id
            self.grams = grams
            self.item = item
            self.isSaved = isSaved
        }
        
        init(intake: Intake) {
            guard let item = intake.item,
                  let grams = intake.grams else { fatalError() }
            self.init(id: intake.id, grams: grams, item: item, isSaved: false)
        }
        
        mutating func update(with intake: Intake) {
            guard let item = intake.item,
                  let grams = intake.grams else { fatalError() }
            self.id = intake.id
            self.grams = grams
            self.item = item
        }
    }
    
    // MARK: - Helpers
    
    private func calculateKcal(proteins: Double, carbs: Double, fat: Double) -> Int {
        
        let proteinKcalPerGram: Double = 4
        let carbKcalPerGram: Double = 4
        let fatKcalPerGram: Double = 9
        
        return Int(proteins * proteinKcalPerGram + carbs * carbKcalPerGram + fat * fatKcalPerGram)
    }
    
    private func totalWeight(from ingredients: [Ingredient]) -> Int {
        guard !ingredients.isEmpty else { return 0 }
        return ingredients.map { $0.grams }.reduce(0, +)
    }
    
    private func calculateProteins(from ingredients: [Ingredient]) -> Double {
        guard !ingredients.isEmpty else { return 0 }
        let proteinsTotalWeight = ingredients.map { $0.item.proteins * Double($0.grams) / 100 }.reduce(0, +)
        let totalWeight = totalWeight(from: ingredients)
        return (proteinsTotalWeight / Double(totalWeight) * 100).round(to: 1)
    }
    
    private func calculateCarbs(from ingredients: [Ingredient]) -> Double {
        guard !ingredients.isEmpty else { return 0 }
        let proteinsTotalWeight = ingredients.map { $0.item.carbs * Double($0.grams) / 100 }.reduce(0, +)
        let totalWeight = totalWeight(from: ingredients)
        return (proteinsTotalWeight / Double(totalWeight) * 100).round(to: 1)
    }
    
    private func calculateFat(from ingredients: [Ingredient]) -> Double {
        guard !ingredients.isEmpty else { return 0 }
        let proteinsTotalWeight = ingredients.map { $0.item.fat * Double($0.grams) / 100 }.reduce(0, +)
        let totalWeight = totalWeight(from: ingredients)
        return (proteinsTotalWeight / Double(totalWeight) * 100).round(to: 1)
    }
}

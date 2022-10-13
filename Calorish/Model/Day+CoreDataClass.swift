//
//  Day+CoreDataClass.swift
//  Calorish
//
//  Created by admin on 19.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreStore
import CoreData
import UIKit

@objc(Day)
class Day: NSManagedObject {
    
    var mealGroups: [MealGroup] {
        
        guard !(meals?.allObjects as! [Meal]).isEmpty else { return [] }
        
        let sortedMeals = (meals?.allObjects as! [Meal]).sorted { (meal1, meal2) in
            guard let time1 = meal1.time,
                  let time2 = meal2.time else { fatalError() }
            return time1 < time2
        }
        
        var groups = Array<MealGroup>()
        var groupedMeals = Array<Meal>()
        
        let time = sortedMeals.first!.time!
        let group = MealGroup(meals: sortedMeals, time: time)
        groups.append(group)
        
        return groups
        
//
//        for meal in sortedMeals {
//
//            if let previousMealTime = groupedMeals.last?.time,
//               let currentMealTime = meal.time {
//
//                // TODO: - проверять, чтобы отличались больше, чем на час (?)
//
//                // не отличается
//                if true {
//                    groupedMeals.append(meal)
//                }
//
//                // отличается
//                else {
//                    guard let meal = groupedMeals.first,
//                          let time = meal.time else { fatalError() }
//
//                    let group = MealGroup(meals: groupedMeals, time: time)
//                    groups.append(group)
//                    groupedMeals.removeAll()
//                }
//
//            }
//        }
//
//        // TODO: - поправить дублирование
//        // последняя группа
//        if let meal = groupedMeals.first,
//           let time = meal.time
//
//        let group = MealGroup(meals: groupedMeals, time: time)
//        groups.append(group)
//
//        return groups
    }
    
    var totalEnergy: CalorieDayEnergy {
        let kcals = (meals?.allObjects as! [Meal]).map { $0.kcal }.reduce(0, +)
        return CalorieDayEnergy(type: .total,
                             eatenKcals: kcals,
                             limitKcals: Int(kcalLimit))        
    }
    
    var proteins: NutrientDayEnergy {
        
        let eatenGrams = (meals?.allObjects as! [Meal]).map { $0.proteins }.reduce(0, +)
        return NutrientDayEnergy(type: .proteins,
                                 eatenGrams: Int(eatenGrams),
                                 limitGrams: Int(proteinGramsLimit))
    }
    
    var carbs: NutrientDayEnergy {
        
        let eatenGrams = (meals?.allObjects as! [Meal]).map { $0.carbs }.reduce(0, +)
        return NutrientDayEnergy(type: .carbs,
                                 eatenGrams: Int(eatenGrams),
                                 limitGrams: Int(carbGramsLimit))
    }
    
    var fat: NutrientDayEnergy {
        
        let eatenGrams = (meals?.allObjects as! [Meal]).map { $0.fat }.reduce(0, +)
        return NutrientDayEnergy(type: .fat,
                                 eatenGrams: Int(eatenGrams),
                                 limitGrams: Int(fatGramsLimit))
    }
}

enum EnergyType {
    
    case proteins
    case carbs
    case fat
    case total
    
    var title: String {
        switch self {
        case .proteins:
            return "Белки"
        case .carbs:
            return "Углеводы"
        case .fat:
            return "Жиры"
        case .total:
            return "Калории"
        }
    }
    
    var color: UIColor {
        switch self {
        case .proteins:
            return #colorLiteral(red: 0, green: 0.662745098, blue: 0.9137254902, alpha: 1)
        case .carbs:
            return #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        case .fat:
            return #colorLiteral(red: 0.9490196078, green: 0.6, blue: 0.2901960784, alpha: 1)
        case .total:
            return #colorLiteral(red: 0, green: 0.6196078431, blue: 0.5176470588, alpha: 1)
        }
    }
    
    var kcalPerGram: Int {
        switch self {
        case .proteins, .carbs:
            return 4
        case .fat:
            return 9
        case .total:
            return 0
        }
    }
}

protocol DayEnergy {
    
    var type: EnergyType { get }
    
    var limitKcals: Int? { get }
    var eatenKcals: Int { get }
    
    var limitGrams: Int? { get }
    var eatenGrams: Int { get }
    
    var eatenPercents: Double { get }
    
    var undereatenKcals: Int { get }
    var overeatenKcals: Int { get }
    
    var undereatenGrams: Int { get }
    var overeatenGrams: Int { get }
}

extension DayEnergy {
    
    var eatenPercents: Double {
        guard let limitKcals = limitKcals, limitKcals > 0  else { return 0 }
        return (Double(eatenKcals) / Double (limitKcals) * 100).round(to: 1)
    }
    
    var undereatenKcals: Int {
        guard let limitKcals = limitKcals,
              eatenKcals < limitKcals else { return 0 }
        return limitKcals - eatenKcals
    }
    
    var overeatenKcals: Int {
        guard let limitKcals = limitKcals,
              eatenKcals > limitKcals else { return 0 }
        return eatenKcals - limitKcals
    }
}

struct NutrientDayEnergy: DayEnergy {
    
    let kcalsPerGram: Int
    let type: EnergyType
    
    let limitKcals: Int?
    let eatenKcals: Int
    
    let limitGrams: Int?
    let eatenGrams: Int
    
    init(type: EnergyType, eatenGrams: Int, limitGrams: Int? = nil) {
        self.type = type
        self.kcalsPerGram = type.kcalPerGram
        self.eatenGrams = eatenGrams
        self.limitGrams = limitGrams
        self.eatenKcals = eatenGrams * kcalsPerGram
        self.limitKcals = (limitGrams != nil) ? limitGrams! * kcalsPerGram : nil
    }
    
    var undereatenGrams: Int {
        return undereatenKcals / kcalsPerGram
    }
    var overeatenGrams: Int {
        return overeatenKcals / kcalsPerGram
    }
}

struct CalorieDayEnergy: DayEnergy {
    
    let type: EnergyType
    let limitKcals: Int?
    let eatenKcals: Int
    
    init(type: EnergyType, eatenKcals: Int, limitKcals: Int? = nil) {
        self.type = type
        self.eatenKcals = eatenKcals
        self.limitKcals = limitKcals
    }
    
    // TODO: - bad implementation
    var limitGrams: Int? { return 0 }
    var eatenGrams: Int { return 0 }
    var undereatenGrams: Int { return 0 }
    var overeatenGrams: Int { return 0 }
}

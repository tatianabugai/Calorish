//
//  MealField.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

// TODO: - объединить в протокол field с text field
protocol NumericField {
    var text: String { get set }
    var isFilled: Bool { get }
    var isValid: Bool { get }
}

extension NumericField {
    
    var isFilled: Bool {
        return !text.isEmpty
    }
    var isValid: Bool {
        return isFilled && Int(text) != nil
    }
}

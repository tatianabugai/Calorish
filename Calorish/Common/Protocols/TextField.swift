//
//  FoodField.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

protocol TextField {
    var text: String { get set }
    var isFilled: Bool { get }
    var isValid: Bool { get }
}

extension TextField {
    
    var isFilled: Bool {
        return !text.isEmpty
    }
    var isValid: Bool {
        return isFilled
    }
}

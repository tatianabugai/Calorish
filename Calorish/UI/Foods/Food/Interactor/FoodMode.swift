//
//  FoodMode.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum FoodMode {
    case edit
    case create
    
    var title: String {
        switch self {
        case .edit:
            return "Изменить продукт"
        case .create:
            return "Новый продукт"
        }
    }
}

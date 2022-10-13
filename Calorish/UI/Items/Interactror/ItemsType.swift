//
//  ItemsType.swift
//  Calorish
//
//  Created by admin on 09.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum ItemsType: Int16 {
    
    case foods
    case recipes
    case all
    
    var title: String {
        switch self {
        case .foods:
            return "Продукты"
        case .recipes:
            return "Рецепты"
        case .all:
            return "Продукты и рецепты"
        }
    }
}

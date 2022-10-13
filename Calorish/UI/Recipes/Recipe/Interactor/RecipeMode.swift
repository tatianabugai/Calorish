//
//  RecipeMode.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum RecipeMode {
    case edit
    case create
    
    var title: String {
        switch self {
        case .edit:
            return "Изменить рецепт"
        case .create:
            return "Новый рецепт"
        }
    }
}

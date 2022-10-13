//
//  FoodType.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum ItemsGroup: Int, CaseIterable {
    case createdByUser
    case createdBySystem
    
    var title: String {
        switch self {
        case .createdByUser:
            return "Мои"
        case .createdBySystem:
            return "База"
        }
    }
}

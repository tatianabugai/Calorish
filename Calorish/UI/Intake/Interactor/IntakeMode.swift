//
//  IntakeMode.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum IntakeMode {
    
    case edit
    case create
    
    func title(for type: Intake.IntakeType) -> String {
        
        switch self {
            
        case .edit:
            
            switch type {
            case .meal: return "Изменить приём пищи"
            case .ingredient: return "Изменить ингредиент"
            case .unknown: return ""
            }
            
            
        case .create:
            
            switch type {
            case .meal: return "Съесть продукт"
            case .ingredient: return "Добавить ингредиент"
            case .unknown: return ""
            }
        }
    }
}

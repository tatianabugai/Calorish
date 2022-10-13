//
//  IntakeViewModel.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct IntakeViewModel {
    
    let title: String
    
    let food: Food
    let weight: Weight
    
    struct Food {
        let name: String
        let placeholder: String
        let isDefined: Bool
    }
    
    struct Weight: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
}

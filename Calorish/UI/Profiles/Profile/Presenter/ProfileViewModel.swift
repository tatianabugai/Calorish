//
//  ProfileViewModel.swift
//  Calorish
//
//  Created by admin on 16.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct ProfileViewModel {
    
    let title: String
    
    let name: Name
    let kcal: Kcal
    
    struct Name: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
    
    struct Kcal: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
}

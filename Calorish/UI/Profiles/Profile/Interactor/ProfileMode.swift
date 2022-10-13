//
//  ProfileMode.swift
//  Calorish
//
//  Created by admin on 16.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

enum ProfileMode {
    case edit
    case create
    
    var title: String {
        switch self {
        case .edit:
            return "Изменить профиль"
        case .create:
            return "Новый профиль"
        }
    }
}

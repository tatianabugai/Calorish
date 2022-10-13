//
//  ProfileFields.swift
//  Calorish
//
//  Created by admin on 17.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct ProfileFields {
    
    var name: Name
    var kcal: Kcal
    
    var isValid: Bool {
        return name.isValid && kcal.isValid
    }
    
    init(name: Name = Name(), kcal: Kcal = Kcal()) {
        self.name = name
        self.kcal = kcal
    }
    
    struct Name: TextField {
        var text: String = ""
    }
    
    struct Kcal: NumericField {
        var text: String = ""
    }
}

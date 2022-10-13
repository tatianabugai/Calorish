//
//  IntakeFields.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

struct IntakeFields {
    
//    var item: Item
    var weight: Weight
    
    var isValid: Bool {
        return /*item.isDefined &&*/ weight.isValid
    }
    
    init(/*item: Item = Item(), */weight: Weight = Weight()) {
//        self.item = item
        self.weight = weight
    }
    
//    struct Item {
//        var title: String?
//        var isDefined: Bool {
//            return title != nil
//        }
//    }
    
    struct Weight: NumericField {
        var text: String = ""
    }
}

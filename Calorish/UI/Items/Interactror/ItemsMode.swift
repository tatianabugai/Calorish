//
//  FoodsMode.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

enum ItemsMode {
    case present
    case select
    
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        switch self {
        case .present:
            return .always
        case .select:
            return .never
        }
    }
}

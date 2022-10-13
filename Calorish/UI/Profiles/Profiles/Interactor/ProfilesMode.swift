//
//  ProfilesMode.swift
//  Calorish
//
//  Created by admin on 23.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

enum ProfilesMode {
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

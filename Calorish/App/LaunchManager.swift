//
//  LaunchManager.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreStore

enum LaunchManager {
    
    static func setup() {
        
//        DataBaseManager.resetDatabase()
        
        guard let profiles = try? CoreStoreDefaults.dataStack.fetchAll(From<Profile>()),
              profiles.isEmpty else { return }
        
        Profile.createDefault()
    }
}

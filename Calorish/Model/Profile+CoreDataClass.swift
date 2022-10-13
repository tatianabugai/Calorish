//
//  Profile+CoreData.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreData
import CoreStore

@objc(Profile)
class Profile: NSManagedObject {
    
    static func createDefault() {
        try? CoreStoreDefaults.dataStack.perform(synchronous: { (transaction) in
            let profile = transaction.create(Into<Profile>())
            profile.id = 1
            profile.name = R.string.localizable.commonUser()
            profile.kcalLimit = 2400
            profile.isSelected = true
            profile.proteinGramsLimit = 100
            profile.carbGramsLimit = 200
            profile.fatGramsLimit = 80
        })
    }
    
    static func fetchSelected() -> Profile? {
        return try? CoreStoreDefaults.dataStack.fetchOne(
            From<Profile>(),
            Where<Profile>(\.isSelected == true))
    }
    
    func viewModel() -> ProfileCellViewModel {
        return ProfileCellViewModel(name: name ?? "",
                                    kcal: String(kcalLimit),
                                    proteinsGrams: String(proteinGramsLimit),
                                    carbsGrams: String(carbGramsLimit),
                                    fatGrams: String(fatGramsLimit),
                                    isSelected: isSelected)
    }
}

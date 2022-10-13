//
//  DataBaseManager.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright © 2022 Tatiana Bugdai. All rights reserved.
//

import Foundation
import CoreStore

enum DataBaseManager {
    
    static func setup() {
        let dataStack = DataStack(xcodeModelName: "DataModel",
                                                bundle: Bundle.main,
                                                migrationChain: ["DataModel"])
        
        do {
            try dataStack.addStorageAndWait(
                SQLiteStore(
                    fileName: "DataModel.sqlite",
                    localStorageOptions: .allowSynchronousLightweightMigration
                )
            )
        } catch {
            //
        }
        CoreStoreDefaults.dataStack = dataStack
    }
    
    static func resetDatabase() {
        try? CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> Void in
            do {
                try transaction.deleteAll(From<Profile>())
                try transaction.deleteAll(From<Day>())
                try transaction.deleteAll(From<Meal>())
                try transaction.deleteAll(From<Food>())
                try transaction.deleteAll(From<Recipe>())
                try transaction.deleteAll(From<Ingredient>())
                try transaction.deleteAll(From<Item>())
            } catch {
                //
            }
        })
    }
}

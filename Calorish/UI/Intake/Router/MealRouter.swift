//
//  IntakeRouter.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol IntakeRoutingLogic: Closable {
    func openItems(output: ItemsOutput)
}

class IntakeRouter: Router<IntakeViewController>, IntakeRoutingLogic {
    
    func openItems(output: ItemsOutput) {
        
        let module = ItemsModule()
        module.input.configure(mode: .select, type: .all)
        module.output = output

        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}

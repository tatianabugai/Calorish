//
//  RecipesRouter.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol RecipeRoutingLogic: Closable {
    func openIntake(_ intake: Intake, mode: IntakeMode, output: IntakeOutput)
}

class RecipeRouter: Router<RecipeViewController>, RecipeRoutingLogic {
    
    func openIntake(_ intake: Intake, mode: IntakeMode, output: IntakeOutput) {
        let module = IntakeModule()
        module.input.configure(intake: intake, mode: mode)
        module.output = output
       
        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}

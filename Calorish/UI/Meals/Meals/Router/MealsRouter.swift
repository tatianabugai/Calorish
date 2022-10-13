//
//  MealsRouter.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol MealsRoutingLogic {
    func openProfiles(output: ProfilesOutput, mode: ProfilesMode)
    func openIntake(intake: Intake, mode: IntakeMode, output: IntakeOutput?)
}

class MealsRouter: Router<MealsViewController>, MealsRoutingLogic {    
    
    func openProfiles(output: ProfilesOutput, mode: ProfilesMode) {
        
        let module = ProfilesModule()
        module.input.configure(mode: mode)
        module.output = output
       
        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
    
    func openIntake(intake: Intake, mode: IntakeMode, output: IntakeOutput? = nil) {
        
        let module = IntakeModule()
        module.input.configure(intake: intake, mode: mode)
        module.output = output
       
        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}

//
//  ProfilesRouter.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugdai. All rights reserved.
//

import UIKit

protocol ProfilesRoutingLogic: Closable {
    func openProfile(profile: Profile?, mode: ProfileMode)
}

class ProfilesRouter: Router<ProfilesViewController>, ProfilesRoutingLogic {
        
    func openProfile(profile: Profile?, mode: ProfileMode) {
        
        let module = ProfileModule()
        module.input.configure(profile: profile, mode: mode)
       
        let navVC = NavigationController(rootViewController: module.viewController)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}

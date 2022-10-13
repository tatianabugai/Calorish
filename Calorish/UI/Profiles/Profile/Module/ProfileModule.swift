//
//  ProfileModule.swift
//  Calorish
//
//  Created by admin on 23.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ProfileInput {
    var profile: Profile? { get set }
    var mode: ProfileMode { get set }
    func configure(profile: Profile?, mode: ProfileMode)
}

class ProfileModule {
    
    var input: ProfileInput {
        return interactor
    }
    
    let viewController: ProfileViewController
    let interactor: ProfileInteractor
    let presenter: ProfilePresenter
    let router: ProfileRouter
    
    init() {
        let router = ProfileRouter()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        guard let viewController = R.storyboard.profile.profileViewController() else {
            fatalError("R.swift should return valid view controller")
        }
        
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        self.router = router
        self.viewController = viewController
        self.presenter = presenter
        self.interactor = interactor
    }
}

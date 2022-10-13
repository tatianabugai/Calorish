//
//  ProfilesModule.swift
//  Calorish
//
//  Created by admin on 23.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ProfilesInput {
    var mode: ProfilesMode { get set }
    func configure(mode: ProfilesMode)
}

protocol ProfilesOutput {
    func didSelectProfile(_ profile: Profile)
}

class ProfilesModule {
    
    var input: ProfilesInput {
        return interactor
    }
    
    var output: ProfilesOutput? {
        get {
            return interactor.output
        }
        set {
            interactor.output = newValue
        }
    }
    
    let viewController: ProfilesViewController
    let interactor: ProfilesInteractor
    let presenter: ProfilesPresenter
    let router: ProfilesRouter
    
    init() {
        let router = ProfilesRouter()
        let presenter = ProfilesPresenter()
        let interactor = ProfilesInteractor()
        guard let viewController = R.storyboard.profiles.profilesViewController() else {
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

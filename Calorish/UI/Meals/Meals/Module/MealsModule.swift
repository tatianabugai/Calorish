//
//  MealsModule.swift
//  Calorish
//
//  Created by admin on 23.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol MealsInput {
}

class MealsModule {
    
    var input: MealsInput {
        return interactor
    }
    
    let viewController: MealsViewController
    let interactor: MealsInteractor
    let presenter: MealsPresenter
    let router: MealsRouter
    
    init() {
        let router = MealsRouter()
        let presenter = MealsPresenter()
        let interactor = MealsInteractor()
        guard let viewController = R.storyboard.meals.mealsViewController() else {
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

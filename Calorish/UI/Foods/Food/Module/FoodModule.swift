//
//  FoodModule.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
protocol FoodInput {
    var food: Food? { get set }
    var mode: FoodMode { get set }
    func configure(food: Food?, mode: FoodMode)
}

class FoodModule {
    
    var input: FoodInput {
        return interactor
    }
    
    let viewController: FoodViewController
    let interactor: FoodInteractor
    let presenter: FoodPresenter
    let router: FoodRouter
    
    init() {
        let router = FoodRouter()
        let presenter = FoodPresenter()
        let interactor = FoodInteractor()
        guard let viewController = R.storyboard.food.foodViewController() else {
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

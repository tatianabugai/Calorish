//
//  FoodsModule.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol ItemsInput {
    var mode: ItemsMode { get set }
    var type: ItemsType { get set }
    func configure(mode: ItemsMode, type: ItemsType)
}

protocol ItemsOutput {
    func didSelectItem(_ item: Item)
}

class ItemsModule {
    
    var input: ItemsInput {
        return interactor
    }
    
    var output: ItemsOutput? {
        get {
            interactor.output
        }
        set {
            interactor.output = newValue
        }
    }
    
    let viewController: ItemsViewController
    let interactor: ItemsInteractor
    let presenter: ItemsPresenter
    let router: ItemsRouter
    
    init() {
        let router = ItemsRouter()
        let presenter = ItemsPresenter()
        let interactor = ItemsInteractor()
        guard let viewController = R.storyboard.items.itemsViewController() else {
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

//
//  IntakeModule.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol IntakeInput {
    var intake: Intake! { get set }
    var mode: IntakeMode { get set }
    func configure(intake: Intake, mode: IntakeMode)
}

protocol IntakeOutput {
    func didTriggerIntakeChanged(intake: Intake)
    func didTriggerIntakeCreated(intake: Intake)
}

class IntakeModule {
    
    var input: IntakeInput {
        return interactor
    }
    
    var output: IntakeOutput? {
        get {
            interactor.output
        }
        set {
            interactor.output = newValue
        }
    }
    
    let viewController: IntakeViewController
    let interactor: IntakeInteractor
    let presenter: IntakePresenter
    let router: IntakeRouter
    
    init() {
        let router = IntakeRouter()
        let presenter = IntakePresenter()
        let interactor = IntakeInteractor()
        guard let viewController = R.storyboard.intake.intakeViewController() else {
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

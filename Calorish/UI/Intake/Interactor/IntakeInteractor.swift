//
//  IntakeInteractor.swift
//  Calorish
//
//  Created by admin on 31.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol IntakeBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTapDoneButton()
    func didTapCancelButton()
    func didTapItemButton()
    
    func didTriggerWeightChangedEvent(_ weight: String)
}

// TODO: - раскидать функционал по расширениям
class IntakeInteractor: IntakeBusinessLogic, IntakeInput {
    
    var presenter: IntakePresentationLogic?
    var router: (NSObjectProtocol & IntakeRoutingLogic)?
    
    var output: IntakeOutput?
 
    var intake: Intake!
    var mode: IntakeMode = .edit
    
    func configure(intake: Intake, mode: IntakeMode) {
        self.intake = intake
        self.mode = mode
    }

    private var fields: IntakeFields = IntakeFields()
    
    func didTriggerViewReadyEvent() {
        
        switch mode {
            
        case .edit:
            guard let intake = intake else { fatalError() }
            setFieldsTo(intake)
            
        case .create:
            setFieldsEmpty()
        }        
        presenter?.presentIntake(intake: intake, mode: mode)
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    func didTapDoneButton() {
        
        // FIX: - мб нужно ставить его во всех местах, где обновляются fields?
        intake.update(with: fields)
        intake.time = Date()
        
        switch mode {
            
        case .edit:
            output?.didTriggerIntakeChanged(intake: intake)
            
        case .create:
            output?.didTriggerIntakeCreated(intake: intake)
        }
        
        router?.close(transitionType: .dismiss)
    }
    
    func didTapCancelButton() {
        router?.close(transitionType: .dismiss)
    }
    
    func didTapItemButton() {
        router?.openItems(output: self)
    }
    
    func didTriggerWeightChangedEvent(_ weight: String) {
        fields.weight.text = weight
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    private func setFieldsTo(_ intake: Intake) {
//        fields.item.title = intake.item?.name ?? ""
        fields.weight.text = String(intake.grams ?? 0)
    }
    
    private func setFieldsEmpty() {
        fields = IntakeFields()
    }
}

extension IntakeInteractor: ItemsOutput {
    
    func didSelectItem(_ item: Item) {
        intake.item = item
        presenter?.presentIntake(intake: intake, mode: mode)
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
}
    

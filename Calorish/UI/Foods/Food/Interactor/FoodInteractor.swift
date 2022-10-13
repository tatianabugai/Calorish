//
//  FoodInteractor.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol FoodBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTapDoneButton()
    func didTapCancelButton()
    func didTriggerNameChangedEvent(_ name: String)
    func didTriggerProteinsChangedEvent(_ proteins: String)
    func didTriggerCarbsChangedEvent(_ carbs: String)
    func didTriggerFatChangedEvent(_ fat: String)
}

class FoodInteractor: FoodBusinessLogic, FoodInput {
    
    var presenter: FoodPresentationLogic?
    var router: (NSObjectProtocol & FoodRoutingLogic)?
    
    var food: Food?
    var mode: FoodMode = .edit
    
    func configure(food: Food?, mode: FoodMode) {
        self.food = food
        self.mode = mode
    }
    
    private var fields: FoodFields = FoodFields()
    
    func didTriggerViewReadyEvent() {
        switch mode {
        case .edit:
            guard let food = food else { return }
            setFieldsTo(food)
            
        case .create:
            setFieldsEmpty()
        }
        presenter?.presentFood(fields: fields, mode: mode)
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    func didTapDoneButton() {
        switch mode {
        case .edit:
            updateFood(matching: fields)
        case .create:
            createFood(matching: fields)
        }
        router?.close(transitionType: .dismiss)
    }
    
    func didTapCancelButton() {
        router?.close(transitionType: .dismiss)
    }
    
    func didTriggerNameChangedEvent(_ name: String) {
        fields.name.text = name
        presenter?.presentDoneButtonEnabled(fields.isValid)
        presenter?.presentKcal(fields.kcal)
    }
    
    func didTriggerProteinsChangedEvent(_ proteins: String) {
        fields.proteins.text = proteins
        presenter?.presentDoneButtonEnabled(fields.isValid)
        presenter?.presentKcal(fields.kcal)
    }
    
    func didTriggerCarbsChangedEvent(_ carbs: String) {
        fields.carbs.text = carbs
        presenter?.presentDoneButtonEnabled(fields.isValid)
        presenter?.presentKcal(fields.kcal)
    }
    
    func didTriggerFatChangedEvent(_ fat: String) {
        fields.fat.text = fat
        presenter?.presentDoneButtonEnabled(fields.isValid)
        presenter?.presentKcal(fields.kcal)
    }
    
    private func createFood(matching fields: FoodFields) {
        
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) in
                
                let food = transaction.create(Into<Food>())
                food.name = fields.name.text
                food.proteins = Double(fields.proteins.text) ?? 0
                food.carbs = Double(fields.carbs.text) ?? 0
                food.fat = Double(fields.fat.text) ?? 0
                
                let item = transaction.create(Into<Item>())                
                item.isCreatedByUser = true
                item.lastTimeUsedAt = Date()
                item.name = food.name
                item.typeRawValue = Item.ItemType.food.rawValue
                item.food = food
            },
            completion: { _ in }
        )
    }
    
    private func updateFood(matching fields: FoodFields) {
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                
                guard let self = self,
                      let food = transaction.edit(self.food),
                      let item = transaction.edit(food.item) else { return }
                
                food.name = self.fields.name.text
                food.proteins = Double(self.fields.proteins.text) ?? 0
                food.carbs = Double(self.fields.carbs.text) ?? 0
                food.fat = Double(self.fields.fat.text) ?? 0
                
                item.name = food.name
                item.lastTimeUsedAt = Date()
            },
            completion: { _ in }
        )
    }
    
    private func setFieldsTo(_ food: Food) {
        fields.name.text = food.name ?? ""
        fields.proteins.text = String(food.proteins)
        fields.carbs.text = String(food.carbs)
        fields.fat.text = String(food.fat)
    }
    
    private func setFieldsEmpty() {
        fields = FoodFields()
    }
}

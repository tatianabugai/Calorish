//
//  ProfileInteractor.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol ProfileBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTapDoneButton()
    func didTapCancelButton()
    func didTriggerNameChangedEvent(_ name: String)
    func didTriggerKcalChangedEvent(_ kcal: String)
}

class ProfileInteractor: ProfileBusinessLogic, ProfileInput {
    
    var presenter: ProfilePresentationLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic/* & ProfileDataPassing*/)?
    
    var profile: Profile?
    var mode: ProfileMode = .edit
    
    func configure(profile: Profile?, mode: ProfileMode) {
        self.profile = profile
        self.mode = mode
    }
    
    private var fields: ProfileFields = ProfileFields()    
    
    func didTriggerViewReadyEvent() {
        switch mode {
        case .edit:
            guard let profile = profile else { return }
            setFieldsTo(profile)
            
        case .create:
            setFieldsEmpty()
        }
        presenter?.presentProfile(fields: fields, mode: mode)
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    func didTapDoneButton() {
        switch mode {
        case .edit:
            updateProfile(matching: fields)
        case .create:
            createProfile(matching: fields)
        }
        router?.close(transitionType: .dismiss)
    }
    
    func didTapCancelButton() {
        router?.close(transitionType: .dismiss)
    }
    
    func didTriggerNameChangedEvent(_ name: String) {
        fields.name.text = name
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    func didTriggerKcalChangedEvent(_ kcal: String) {
        fields.kcal.text = kcal
        presenter?.presentDoneButtonEnabled(fields.isValid)
    }
    
    private func createProfile(matching fields: ProfileFields) {
        
        let maxId = (try? CoreStoreDefaults.dataStack.queryValue(
            From<Profile>(),
            Select<Profile, Int16>(.maximum(\.id)))) ?? 0
        let id = maxId + 1
        
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) in
                let profile = transaction.create(Into<Profile>())
                profile.id = id
                profile.name = fields.name.text
                profile.kcalLimit = Int16(fields.kcal.text) ?? 0
                profile.isSelected = false
                profile.proteinGramsLimit = 0
                profile.carbGramsLimit = 0
                profile.fatGramsLimit = 0
            },
            completion: { _ in }
        )
    }
    
    private func updateProfile(matching fields: ProfileFields) {
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                guard let self = self,
                      let profile = transaction.edit(self.profile) else { return }
                profile.name = self.fields.name.text
                profile.kcalLimit = Int16(self.fields.kcal.text) ?? 0
            },
            completion: { _ in }
        )
    }
    
    private func setFieldsTo(_ profile: Profile) {
        fields.name.text = profile.name ?? ""
        fields.kcal.text = String(profile.kcalLimit)
    }
    
    private func setFieldsEmpty() {
        fields = ProfileFields()
    }
}

//
//  MealsInteractor.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol MealsBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTapProfileButton()
    func didTapAddButton()
    func didSelectRow(at indexPath: IndexPath)
}

class MealsInteractor: MealsBusinessLogic, MealsInput {
    
    var presenter: MealsPresentationLogic?
    var router: (NSObjectProtocol & MealsRoutingLogic)?

    private var date: Date = Date().date
    private var dayMonitor: ObjectMonitor<Day>!
    
    func didTriggerViewReadyEvent() {
        
        if let profiles = try? CoreStoreDefaults.dataStack.fetchAll(From<Profile>()),
           profiles.isEmpty {
            Profile.createDefault()
        }
        
        guard let profile = try? CoreStoreDefaults.dataStack.fetchOne(
            From<Profile>(),
            Where<Profile>(\.isSelected == true))
        else { fatalError() }
        
        updateDayMonitor(with: profile) { [weak self] in
            guard let self = self else { return }
            self.dayMonitor.addObserver(self)
            
            guard let day = self.dayMonitor.object else { fatalError() }
            self.presenter?.present(day: day)
        }
    }
    
    func didTapProfileButton() {
        router?.openProfiles(output: self, mode: .select)
    }
    
    func didTapAddButton() {
        router?.openIntake(intake: Intake(emptyOfType: .meal), mode: .create, output: self)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        guard let day = dayMonitor.object else { fatalError() }
        
        let groups = day.mealGroups
        let meals = groups[indexPath.section].meals
        let meal = meals[indexPath.row]
      
        router?.openIntake(intake: Intake(meal: meal), mode: .edit, output: self)
    }
    
    // TODO: - refactoring
    private func updateDayMonitor(with profile: Profile, completion: @escaping () -> ()) {
                
        if let day = try? CoreStoreDefaults.dataStack.fetchOne(
            From<Day>(),
            Where<Day>(\.date == date && \.profileId == profile.id)) {
            
            dayMonitor = CoreStoreDefaults.dataStack.monitorObject(day)
            completion()
            
        } else {
            try? CoreStoreDefaults.dataStack.perform(
                asynchronous: { [weak self] (transaction) in
                    guard let profile = transaction.fetchExisting(profile) else { fatalError("Profile should exist") }
                    let newDay = transaction.create(Into<Day>())
                    newDay.kcalLimit = profile.kcalLimit
                    newDay.proteinGramsLimit = profile.proteinGramsLimit
                    newDay.carbGramsLimit = profile.carbGramsLimit
                    newDay.fatGramsLimit = profile.fatGramsLimit
                    newDay.date = self?.date
                    newDay.profile = profile
                    newDay.profileId = profile.id
                },
                completion: { [weak self] _ in
                    guard let day = try? CoreStoreDefaults.dataStack.fetchOne(From<Day>(), Where<Day>(\.date == self?.date && \.profileId == profile.id)) else { fatalError() }
                    self?.dayMonitor = CoreStoreDefaults.dataStack.monitorObject(day)
                    completion()
                })
        }
    }
    
}

extension MealsInteractor: ProfilesOutput {
    
    func didSelectProfile(_ profile: Profile) {
        
        updateDayMonitor(with: profile) { [weak self] in
            guard let day = self?.dayMonitor.object else { fatalError() }
            self?.presenter?.present(day: day)
        }
    }
}

extension MealsInteractor: IntakeOutput {
    
    func didTriggerIntakeChanged(intake: Intake) {
        
        updateMeal(matching: intake)
        
        guard let day = dayMonitor.object else { fatalError() }
        presenter?.present(day: day)
    }
    
    func didTriggerIntakeCreated(intake: Intake) {
        
        createMeal(matching: intake)
        
        guard let day = dayMonitor.object else { fatalError() }
        presenter?.present(day: day)
    }
    
    private func createMeal(matching intake: Intake) {
        
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                guard let self = self,
                      let item = transaction.edit(intake.item),
                      let day = try? transaction.fetchOne(From<Day>(), Where<Day>(\.date == self.date))
                else { return }
                
                let meal = transaction.create(Into<Meal>())
                meal.item = item
                meal.grams = Int16(intake.grams ?? 0)
                meal.id = UUID()
                meal.day = day
                meal.time = intake.time
            },
            completion: { _ in }
        )
    }
    
    private func updateMeal(matching intake: Intake) {
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { [weak self] (transaction) in
                guard let self = self,
                      let meal = try? transaction.fetchOne(From<Meal>(), Where<Meal>(\.id == intake.id)),
                      let itemId = intake.item?.id,
                      let item = try? transaction.fetchOne(From<Item>(), Where<Item>(\.id == itemId))
                else { return }
                
                meal.item = item
                meal.grams = Int16(intake.grams ?? 0)
                meal.time = intake.time
            },
            completion: { _ in }
        )
    }
}

extension MealsInteractor: ObjectObserver {
    
    typealias ObjectEntityType = Day
    
    func objectMonitor(_ monitor: ObjectMonitor<Day>, willUpdateObject object: Day) {
    }
    
    func objectMonitor(_ monitor: ObjectMonitor<Day>, didUpdateObject object: Day, changedPersistentKeys: Set<KeyPathString>) {
//        guard let profile = object.profile else { fatalError("Profile should exists") }
        presenter?.present(day: object)
    }
    
    func objectMonitor(_ monitor: ObjectMonitor<Day>, didDeleteObject object: Day) {
        // TODO: 
       
    }
}

//extension MealsInteractor: ListObserver {
//    
//    typealias ListEntityType = GroupedMeal
//    
//    func listMonitorDidChange(_ monitor: ListMonitor<GroupedMeal>) {
//    }
//    
//    func listMonitorDidRefetch(_ monitor: ListMonitor<GroupedMeal>) {
//    }
//}

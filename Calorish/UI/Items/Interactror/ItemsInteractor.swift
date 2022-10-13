//
//  FoodsInteractor.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation
import CoreStore

protocol ItemsBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTriggerSegmentChangedEvent(index: Int)
    func didTriggerSearchTextChangedEvent(text: String)
    func didTapAddButton()
    func didSelectRow(at indexPath: IndexPath)
}

class ItemsInteractor: ItemsBusinessLogic, ItemsInput {
    
    var output: ItemsOutput?
    
    var presenter: ItemsPresentationLogic?
    var router: ItemsRoutingLogic?
    
    var monitor: ListMonitor<Item>!
    var group: ItemsGroup = .createdByUser
    
    var mode: ItemsMode = .present
    var type: ItemsType = .foods
    
    func configure(mode: ItemsMode, type: ItemsType) {
        self.mode = mode
        self.type = type
    }
    
    func didTriggerViewReadyEvent() {
        
        monitor = try? CoreStoreDefaults.dataStack.monitorList(
            From<Item>(),
            whereFilter(type: type, group: group),
            OrderBy<Item>(.ascending(\.lastTimeUsedAt))
        )
        monitor.addObserver(self)
        
        let groups: [ItemsGroup] = {
            switch type {
            case .foods, .all:
                return [.createdByUser, .createdBySystem]
            case .recipes:
                return []
            }
        }()
            
        let segmentTitles = groups.map { $0.title }
        
        presenter?.presentTitle(type.title)
        presenter?.presentSegmentedControlTitles(segmentTitles)
        presenter?.presentItems(monitor, mode: mode)
        
    }
    
    func didTapAddButton() {
        
        switch type {
            
        case .foods:
            router?.openFood(food: nil, mode: .create)

        case .recipes:
            router?.openRecipe(recipe: nil, mode: .create)

        case .all:
            let alertModel = alertModel()
            presenter?.presentAlert(model: alertModel)
        }
    }
    
    func didTriggerSegmentChangedEvent(index: Int) {
        
        guard let group = ItemsGroup(rawValue: index) else { return }
        self.group = group
        
        monitor.refetch(whereFilter(type: type, group: group),
                        OrderBy<Item>(.ascending(\.lastTimeUsedAt)))
        
        presenter?.presentItems(monitor, mode: mode)
    }
    
    func didTriggerSearchTextChangedEvent(text: String) {
        
        let whereFilter: Where<Item> = {
            let nameFilter = Where<Item>(NSPredicate(format: "name CONTAINS[c] %@", text))
            let isCreatedByUserFilter = Where<Item>(\.isCreatedByUser == (group == .createdByUser))
            
            switch text {
            case "": return isCreatedByUserFilter
            default: return nameFilter && isCreatedByUserFilter
            }
        }()
        
        monitor.refetch(whereFilter,
                        OrderBy<Item>(.ascending(\.lastTimeUsedAt)))
        
        presenter?.presentItems(monitor, mode: mode)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        let item = monitor.objectsInAllSections()[indexPath.row]
        
        switch mode {
        case .present:
            
            switch type {
            case .foods:
                guard let food = item.food else { fatalError() }
                router?.openFood(food: food, mode: .edit)
                
            case .recipes:
                guard let recipe = item.recipe else { fatalError() }
                router?.openRecipe(recipe: recipe, mode: .edit)
                
            case .all:
                break
            }
            
        case .select:
            output?.didSelectItem(item)
            router?.close(transitionType: .dismiss)
        }
    }
    
    private func alertModel() -> AlertModel {
        
        let addFoodAction = AlertActionModel(title: R.string.localizable.alertAddFood(),
                                                  style: .default,
                                                  handler: { [weak self] _ in
            self?.router?.openFood(food: nil, mode: .create)
        })
        
        let addRecipeAction = AlertActionModel(title: R.string.localizable.alertAddRecipe(),
                                               style: .default,
                                               handler: { [weak self] _ in
            self?.router?.openRecipe(recipe: nil, mode: .create)
        })
        
        let cancelAction = AlertActionModel(title: R.string.localizable.commonCancel(),
                                            style: .cancel,
                                            handler: nil)
        
        return AlertModel(title: nil,
                          message: nil,
                          style: .actionSheet,
                          actions: [addFoodAction, addRecipeAction, cancelAction])        
    }
    
    private func whereFilter(type: ItemsType, group: ItemsGroup) -> Where<Item> {
        
        let isCreatedByUserFilter = Where<Item>(\.isCreatedByUser == (group == .createdByUser))
        let typeRawValueFilter = Where<Item>(\.typeRawValue == type.rawValue)
        
        switch type {
        case .foods, .recipes:
            return isCreatedByUserFilter && typeRawValueFilter
        case .all:
            return isCreatedByUserFilter
        }
    }
}

extension ItemsInteractor: ListObserver {
    
    typealias ListEntityType = Item
    
    func listMonitorDidChange(_ monitor: ListMonitor<Item>) {
        presenter?.presentItems(monitor, mode: mode)
    }
    func listMonitorDidRefetch(_ monitor: ListMonitor<Item>) {
        presenter?.presentItems(monitor, mode: mode)
    }
}

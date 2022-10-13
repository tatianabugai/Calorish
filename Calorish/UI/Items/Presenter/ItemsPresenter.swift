//
//  FoodsPresenter.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol ItemsPresentationLogic {
    func presentTitle(_ title: String)
    func presentSegmentedControlTitles(_ titles: [String])
    func presentItems(_ items: ListMonitor<Item>, mode: ItemsMode)
    func presentAlert(model: AlertModel)
}

class ItemsPresenter: ItemsPresentationLogic {
    
    weak var viewController: ItemsDisplayLogic?
    
    func presentTitle(_ title: String) {
        viewController?.setTitle(title)
    }
    
    func presentSegmentedControlTitles(_ titles: [String]) {
        viewController?.setSegmentedControlTitles(titles)
    }
    
    func presentItems(_ items: ListMonitor<Item>, mode: ItemsMode) {
        
        let largeTitleDisplayMode = mode.largeTitleDisplayMode
        let cells = items.objectsInAllSections().map { $0.viewModel() }
        let foodsViewModel = ItemsViewModel(largeTitleDisplayMode: largeTitleDisplayMode,
                                            cells: cells)
        
        viewController?.displayFoods(viewModel: foodsViewModel)
    }
    
    func presentAlert(model: AlertModel) {
        viewController?.displayAlert(model: model)
    }
}

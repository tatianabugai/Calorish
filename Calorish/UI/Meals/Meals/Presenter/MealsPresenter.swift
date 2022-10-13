//
//  MealsPresenter.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import CoreStore

protocol MealsPresentationLogic {
    func present(day: Day)
}

class MealsPresenter: MealsPresentationLogic {
    weak var viewController: MealsDisplayLogic?
    
    func present(day: Day) {
        
        let proteins = caloriesViewModel(for: day.proteins)
        let carbs = caloriesViewModel(for: day.carbs)
        let fat = caloriesViewModel(for: day.fat)
        let total = caloriesViewModel(for: day.totalEnergy)
        
        let kcalDetails = MealsHeaderKcalDetailsViewModel(proteins: proteins,
                                                          carbs: carbs,
                                                          fat: fat,
                                                          total: total)
        
        let header = MealsHeaderViewModel(kcalDetails: kcalDetails)
        
        let table = tableViewModel(for: day.mealGroups)
        
        let viewModel = MealsViewModel(profileName: day.profile?.name ?? "",
                                       header: header,
                                       table: table)
        
        viewController?.display(viewModel: viewModel)
    }
    
    private func caloriesViewModel(for energy: DayEnergy) -> CaloriesViewModel {
        
        let progressBarViewModel = ProgressBarViewModel(color: energy.type.color,
                                                        progress: energy.eatenPercents / 100)
        
        let amount: String = {
            switch energy.type {
            case .total:
                return "\(String(energy.eatenKcals))/\(String(energy.limitKcals ?? 0))"
            default:
                return "\(String(energy.eatenGrams))/\(String(energy.limitGrams ?? 0))"
            }
        }()
        
        let percentAmount = energy.eatenPercents == 0 ? nil : String(energy.eatenPercents) + "%"
        
        let kcalAmount: String? = {
            switch energy.type {
            case .total:
                return (energy.undereatenKcals == 0 || energy.undereatenKcals == energy.limitKcals) ? nil : String(energy.undereatenKcals) + " до лим."
            default:
                return (energy.eatenKcals == 0) ? nil : String(energy.eatenKcals) + " ккал"
            }
        }()
        
        let overeatenAmount: String? = {
            switch energy.type {
            case .total:
                return energy.overeatenKcals == 0 ? nil : "+" + String(energy.overeatenKcals)
            default:
                return energy.overeatenGrams == 0 ? nil : "+" + String(energy.overeatenGrams)
            }
        }()
        
        return CaloriesViewModel(title: energy.type.title,
                                 amount: amount,
                                 percentAmount: percentAmount,
                                 kcalAmount: kcalAmount,
                                 overeatenAmount: overeatenAmount,
                                 progressBarViewModel: progressBarViewModel)
        
    }
    
    private func tableViewModel(for groups: [MealGroup]) -> MealsTableViewModel {
        
        var sections = [MealsTableViewModel.Section]()
        
        for group in groups {
            let sectionViewModel = group.viewModel
            let cellViewModels = (group.meals).map { $0.viewModel }
            
            let section = MealsTableViewModel.Section(section: sectionViewModel,
                                                      cells: cellViewModels)
            sections.append(section)
        }
        
        return MealsTableViewModel(sections: sections)
    }
}

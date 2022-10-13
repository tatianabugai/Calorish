//
//  MealsHeaderVIew.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct MealsHeaderKcalDetailsViewModel {
    let proteins: CaloriesViewModel
    let carbs: CaloriesViewModel
    let fat: CaloriesViewModel
    let total: CaloriesViewModel
}

struct MealsHeaderViewModel {
    var kcalDetails: MealsHeaderKcalDetailsViewModel
}

@IBDesignable
class MealsHeaderView: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private var proteinsView: CaloriesView!
    @IBOutlet private var fatView: CaloriesView!
    @IBOutlet private var carbsView: CaloriesView!
    @IBOutlet private var kcalView: CaloriesView!
    
    static let height: CGFloat = 150
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("MealsHeaderView", owner: self, options: nil)
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setup(with viewModel: MealsHeaderViewModel) {
        proteinsView.setup(with: viewModel.kcalDetails.proteins)
        carbsView.setup(with: viewModel.kcalDetails.carbs)
        fatView.setup(with: viewModel.kcalDetails.fat)
        kcalView.setup(with: viewModel.kcalDetails.total)
    }
}

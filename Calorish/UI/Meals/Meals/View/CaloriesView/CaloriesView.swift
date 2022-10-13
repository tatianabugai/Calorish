//
//  CaloriesView.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct CaloriesViewModel {
    let title: String
    let amount: String
    let percentAmount: String?
    let kcalAmount: String?
    let overeatenAmount: String?
    let progressBarViewModel: ProgressBarViewModel
}

@IBDesignable
class CaloriesView: UIView {
    
    @IBOutlet private var view: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var kcalLabel: UILabel!
    @IBOutlet var overeatenAmountLabel: UILabel!
    @IBOutlet var progressBarView: ProgressBarView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        // Load nib
        Bundle.main.loadNibNamed("CaloriesView", owner: self, options: nil)
        
        // Setup view
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func layoutSubviews() {
        
    }
    
    func setup(with viewModel: CaloriesViewModel) {
        titleLabel.text = viewModel.title
        amountLabel.text = viewModel.amount
        percentLabel.text = viewModel.percentAmount
        kcalLabel.text = viewModel.kcalAmount
        overeatenAmountLabel.text = viewModel.overeatenAmount
        
        percentLabel.isHidden = viewModel.percentAmount == nil
        kcalLabel.isHidden = viewModel.kcalAmount == nil
        overeatenAmountLabel.isHidden = viewModel.overeatenAmount == nil 
        
        progressBarView.setup(with: viewModel.progressBarViewModel)
    }
}


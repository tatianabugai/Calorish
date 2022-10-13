//
//  RecipeHeaderView.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct RecipeHeaderViewModel {
    var name: Name
    var kcal: String
    var nutrients: String
    var ingredientsTitle: String
    
    struct Name: TextFieldViewModel {
        let text: String
        let placeholder: String
    }
}

class RecipeHeaderView: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private(set) var nameTextFieldView: TextFieldView!
    @IBOutlet private var kcalLabel: UILabel!
    @IBOutlet private var nutrientsLabel: UILabel!
    @IBOutlet private var ingredientsLabel: UILabel!
    
    static let height: CGFloat = 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("RecipeHeaderView", owner: self, options: nil)
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]        
        view.backgroundColor = .systemGray6
    }
    
    func setup(with viewModel: RecipeHeaderViewModel) {
        nameTextFieldView.setup(with: viewModel.name)
        kcalLabel.text = viewModel.kcal
        nutrientsLabel.text = viewModel.nutrients
        ingredientsLabel.text = viewModel.ingredientsTitle
    }
}


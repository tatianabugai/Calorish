//
//  MealCell.swift
//  Calorish
//
//  Created by admin on 02.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct MealCellViewModel {
    var name: String
    var nutrients: String
    var kcal: String
}

class MealCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nutrientsLabel: UILabel!    
    @IBOutlet var kcalLabel: UILabel!
    
    static let height: CGFloat = 75
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }    
    
    func setup(with viewModel: MealCellViewModel) {
        nameLabel.text = viewModel.name
        nutrientsLabel.text = viewModel.nutrients
        kcalLabel.text = viewModel.kcal
    }
}

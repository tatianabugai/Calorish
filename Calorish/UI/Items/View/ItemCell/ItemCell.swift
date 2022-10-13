//
//  FoodCell.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct ItemCellViewModel {
    let name: String
    let kcal: String
    let proteinsGrams: String
    let carbsGrams: String
    let fatGrams: String
}

class ItemCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var kcalLabel: UILabel!
        
    static let height: CGFloat = 68
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with viewModel: ItemCellViewModel) {
        nameLabel.text = viewModel.name
        kcalLabel.text = "\(Constants.protShort): \(viewModel.proteinsGrams)  \(Constants.fatShort): \(viewModel.fatGrams)  \(Constants.carbShort): \(viewModel.carbsGrams)  \(Constants.kcalShort.capitalized): \(viewModel.kcal)"       
    }
}

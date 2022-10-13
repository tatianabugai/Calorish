//
//  ProfileCell.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright © 2022 Tatiana Bugdai. All rights reserved.
//

import UIKit

struct ProfileCellViewModel {
    let name: String
    let kcal: String
    let proteinsGrams: String
    let carbsGrams: String
    let fatGrams: String
    let isSelected: Bool
}

protocol ProfileCellDelegate: AnyObject {
    func didTapCheckmarkView(_ cell: UITableViewCell)
}

class ProfileCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var kcalLabel: UILabel!
    @IBOutlet private var ratioLabel: UILabel!
    @IBOutlet private var checkmarkView: UIView!
    @IBOutlet private var checkmarkImageView: UIImageView!
    
    weak var delegate: ProfileCellDelegate?
    
    static let height: CGFloat = 80
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkmarkView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(didTapCheckmarkView)))
    }
    
    @objc func didTapCheckmarkView() {
        delegate?.didTapCheckmarkView(self)
    }
    
    func setup(with viewModel: ProfileCellViewModel) {
        
        nameLabel.text = viewModel.name
        kcalLabel.text = "\(viewModel.kcal) \(Constants.kcalShort)"
        ratioLabel.text = "\(Constants.protShort): \(viewModel.proteinsGrams) / \(Constants.fatShort): \(viewModel.fatGrams) / \(Constants.carbShort): \(viewModel.carbsGrams)"
        
        checkmarkImageView.image = viewModel.isSelected ? UIImage.checkmark : UIImage()
    }
}

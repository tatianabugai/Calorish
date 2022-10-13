//
//  AlertModel.swift
//  Calorish
//
//  Created by admin on 16.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct AlertModel {
    let title: String?
    let message: String?
    let style: UIAlertController.Style
    
    let actions: [AlertActionModel]
}

struct AlertActionModel {
    let title: String
    let style: UIAlertAction.Style
    let handler: ((UIAlertAction) -> Void)?
}

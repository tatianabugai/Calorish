//
//  UIAlertController.swift
//  Calorish
//
//  Created by admin on 16.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    convenience init(model: AlertModel) {
        self.init(title: model.title,
                  message: model.message,
                  preferredStyle: model.style)
        
        for actionModel in model.actions {
            let action = UIAlertAction(title: actionModel.title,
                                       style: actionModel.style,
                                       handler: actionModel.handler)
            self.addAction(action)
        }
    }
}

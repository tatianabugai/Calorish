//
//  FoodRouter.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol FoodRoutingLogic: Closable {
}

class FoodRouter: Router<FoodViewController>, FoodRoutingLogic {
}

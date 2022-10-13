//
//  Double.swift
//  Calorish
//
//  Created by admin on 08.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

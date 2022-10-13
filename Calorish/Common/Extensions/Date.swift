//
//  Date.swift
//  Calorish
//
//  Created by admin on 24.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

extension Date {

    var date: Date {
        get {
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calendar.date(from: dateComponents)!
        }
    }
    
    var time: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        dateComponents.timeZone = NSTimeZone.system
        return calendar.date(from: dateComponents)!
    }
}

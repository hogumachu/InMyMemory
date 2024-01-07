//
//  Date+.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation

public extension Date {
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    func clipDate() -> Date {
        return Calendar.current.date(from: .init(year: year, month: month, day: day))!
    }
    
    func daysAgo(value: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -value, to: self)!
    }
    
    func monthsAgo(value: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: -value, to: self)!
    }
    
}

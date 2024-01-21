//
//  DateFactory.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

import Foundation

public class DateFactory {
    
    public let calendar: Calendar
    
    public init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    public func makeDate(year: Int, month: Int, day: Int) -> Date? {
        return calendar.date(from: .init(
            year: year,
            month: month,
            day: day
        ))
    }
    
}

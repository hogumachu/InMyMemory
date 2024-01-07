//
//  DayMetaData.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation

public struct DayMetaData {
    public let date: Date
    public let number: Int
    public let isValid: Bool
    
    public init(date: Date, number: Int, isValid: Bool) {
        self.date = date
        self.number = number
        self.isValid = isValid
    }
}

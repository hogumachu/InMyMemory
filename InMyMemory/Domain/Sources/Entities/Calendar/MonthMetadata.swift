//
//  MonthMetadata.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation

public struct MonthMetadata {
    public let numberOfDays: Int
    public let firstDate: Date
    public let firstDateOffset: Int
    
    public init(numberOfDays: Int, firstDate: Date, firstDateOffset: Int) {
        self.numberOfDays = numberOfDays
        self.firstDate = firstDate
        self.firstDateOffset = firstDateOffset
    }
}

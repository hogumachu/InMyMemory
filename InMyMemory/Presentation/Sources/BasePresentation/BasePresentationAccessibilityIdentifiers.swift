//
//  BasePresentationAccessibilityIdentifiers.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

import Foundation

public struct BasePresentationAccessibilityIdentifiers {
    
    public struct Calendar {
        public struct MonthView {
            public static let leftButton = "Calendar.MonthView.leftButton"
            public static let rightButton = "Calendar.MonthView.rightButton"
        }
        
        public struct DayView {
            public static func view(day: Int) -> String {
                return "Calendar.DayView.view.\(day)"
            }
        }
    }
    
}

//
//  CalendarListSection.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation

enum CalendarListSection {
    
    case todo([CalendarListItem])
    case emotion([CalendarListItem])
    case memory([CalendarListItem])
    
    var title: String {
        switch self {
        case .todo: return "할 일"
        case .emotion: return "감정"
        case .memory: return "기억"
        }
    }
    
    var items: [CalendarListItem] {
        switch self {
        case .todo(let items): return items
        case .emotion(let items): return items
        case .memory(let items): return items
        }
    }
    
}

enum CalendarListItem {
    case todo(CalendarTodoListCellModel)
    case emotion(CalendarEmotionListCellModel)
    case memory(CalendarMemoryListCellModel)
}

//
//  SearchSection.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import RxDataSources

enum SearchSection: SectionModelType {
    
    case emotion([SectionItem])
    case memory([SectionItem])
    case todo([SectionItem])
    
    init(original: SearchSection, items: [SectionItem]) {
        self = original
    }
    
    var items: [SectionItem] {
        switch self {
        case .emotion(let items): return items
        case .memory(let items): return items
        case .todo(let items): return items
        }
    }
    
    var header: String {
        switch self {
        case .emotion: return "감정"
        case .memory: return "기억"
        case .todo: return "할일"
        }
    }
}

enum SectionItem {
    case emotion(SearchResultEmotionCellModel)
    case memory(SearchResultMemoryCellModel)
    case todo(SearchResultTodoCellModel)
}

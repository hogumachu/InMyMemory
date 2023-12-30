//
//  NavigationViewButtonType.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

public enum NavigationViewLeftButtonType {
    case back
    case close
    case none
}

extension NavigationViewLeftButtonType {
    
    var title: String {
        switch self {
        case .back: return "뒤로가기"
        case .close: return "닫기"
        case .none: return ""
        }
    }
}

public enum NavigationViewRightButtonType {
    case search
    case plus
    case none
}

extension NavigationViewRightButtonType {
    
    var image: UIImage? {
        switch self {
        case .search: return UIImage(resource: .search)
        case .plus: return UIImage(resource: .plus)
        case .none: return nil
        }
    }
    
}

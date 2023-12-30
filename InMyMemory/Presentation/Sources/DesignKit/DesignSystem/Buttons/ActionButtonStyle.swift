//
//  ActionButtonStyle.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

public enum ActionButtonStyle {
    
    case normal
    case border
    
    var textColor: UIColor {
        switch self {
        case .normal: return .background
        case .border: return .orange1
        }
    }
    
    var disabledTextColor: UIColor {
        switch self {
        case .normal: return .background
        case .border: return .lightGray
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal: return .orange1
        case .border: return .background
        }
    }
    
    var disabledBackgroundColor: UIColor {
        switch self {
        case .normal: return .orange2
        case .border: return .darkGray
        }
    }
    
    var pressedBackgroundColor: UIColor {
        switch self {
        case .normal: return .black.withAlphaComponent(0.3)
        case .border: return .black.withAlphaComponent(0.3)
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .normal: return 0
        case .border: return 1
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .normal: return .clear
        case .border: return .orange1
        }
    }
    
    var disabledBorderColor: UIColor {
        return disabledBackgroundColor
    }
    
    var font: UIFont {
        switch self {
        case .normal: return .gmarketSans(type: .medium, size: 21)
        case .border: return .gmarketSans(type: .medium, size: 21)
        }
    }
    
    var disabledFont: UIFont {
        return font
    }
    
}

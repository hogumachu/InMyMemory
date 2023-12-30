//
//  UIFont+.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

public extension UIFont {
    
    enum GmarketSans {
        case light
        case medium
        case bold
        
        var name: String {
            let family = "GmarketSans"
            switch self {
            case .light: return family + "Light"
            case .medium: return family + "Medium"
            case .bold: return family + "Bold"
            }
        }
    }
    
    static func gmarketSans(type: GmarketSans, size: CGFloat) -> UIFont {
        return UIFont(name: type.name, size: size) ?? .systemFont(ofSize: size)
    }
    
}

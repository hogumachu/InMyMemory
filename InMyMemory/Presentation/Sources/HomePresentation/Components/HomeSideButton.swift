//
//  HomeSideButton.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

enum HomeSideButtonStyle {
    case menu
    case close
    
    var image: UIImage {
        switch self {
        case .menu: return .menu
        case .close: return .xmark
        }
    }
}

final class HomeSideButton: ActionButton {
    
    func updateStyle(style: HomeSideButtonStyle) {
        setImage(style.image.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
}

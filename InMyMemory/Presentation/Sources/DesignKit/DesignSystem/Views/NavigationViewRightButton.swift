//
//  NavigationViewRightButton.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

final class NavigationViewRightButton: UIButton {
    
    var type: NavigationViewRightButtonType = .none {
        didSet { setupType() }
    }
    
    override var isHighlighted: Bool {
        didSet { tintColor = isHighlighted ? .orange2 : .orange1 }
    }
    
    private func setupType() {
        setImage(type.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
}

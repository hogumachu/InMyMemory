//
//  NavigationViewLeftButton.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

final class NavigationViewLeftButton: UIButton {
    
    var type: NavigationViewLeftButtonType = .none {
        didSet { setupType() }
    }
    
    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? .orange2 : .orange1
        }
    }
    
    private func setupType() {
        setTitle(type.title, for: .normal)
        setTitleColor(.orange1, for: .normal)
        setTitleColor(.orange2, for: .highlighted)
    }
    
}

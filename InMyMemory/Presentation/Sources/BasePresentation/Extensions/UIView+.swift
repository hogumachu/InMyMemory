//
//  UIView+.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit

public extension UIView {
    
    func addTapGesture() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer()
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }
    
}

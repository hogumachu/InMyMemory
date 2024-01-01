//
//  EventThroughView.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import UIKit

open class EventThroughView: UIView {
    
    public var isThroughable = true
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self && isThroughable {
            return nil
        } else {
            return view
        }
    }
    
}

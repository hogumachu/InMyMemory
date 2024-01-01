//
//  Rx+UIView.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIView {
    
    var recognizedTap: ControlEvent<Void> {
        let source = base.addTapGesture().rx.event
            .filter { $0.state == .recognized }
            .map { _ in () }
        return ControlEvent(events: source)
    }
    
}


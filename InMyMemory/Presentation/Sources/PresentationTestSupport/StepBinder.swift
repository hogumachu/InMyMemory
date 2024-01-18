//
//  StepBinder.swift
//
//
//  Created by 홍성준 on 1/18/24.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

public final class StepBinder {
    
    public init() {}
    
    public var step: Binder<Step> {
        return Binder(self) { this, step in
            this.steps.append(step)
        }
    }
    
    public var steps: [Step] = []
    
}

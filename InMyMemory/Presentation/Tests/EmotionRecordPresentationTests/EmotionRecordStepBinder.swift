//
//  EmotionRecordStepBinder.swift
//  
//
//  Created by 홍성준 on 1/18/24.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

final class EmotionRecordStepBinder {
    
    var step: Binder<Step> {
        return Binder(self) { this, step in
            this.steps.append(step)
        }
    }
    
    var steps: [Step] = []
    
}

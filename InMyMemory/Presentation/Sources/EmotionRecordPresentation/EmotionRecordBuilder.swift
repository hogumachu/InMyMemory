//
//  EmotionRecordBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import EmotionRecordInterface

public final class EmotionRecordBuilder: EmotionRecordBuildable {
    
    public init() {}
    
    public func build(injector: DependencyInjectorInterface, date: Date) -> Flow {
        return EmotionRecordFlow(injector: injector, date: date)
    }
    
}

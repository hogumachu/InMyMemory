//
//  EmotionDetailBuilder.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import RxFlow
import CoreKit
import EmotionDetailInterface

public final class EmotionDetailBuilder: EmotionDetailBuildable {
    
    public init() {}
    
    public func build(emotionID: UUID, injector: DependencyInjectorInterface) -> Flow {
        return EmotionDetailFlow(emotionID: emotionID, injector: injector)
    }
    
}

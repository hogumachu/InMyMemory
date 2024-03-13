//
//  EmotionDetailAssembly.swift
//  
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import Swinject
import EmotionDetailInterface

public struct EmotionDetailAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(EmotionDetailBuildable.self) { _ in
            EmotionDetailBuilder()
        }
    }
    
}

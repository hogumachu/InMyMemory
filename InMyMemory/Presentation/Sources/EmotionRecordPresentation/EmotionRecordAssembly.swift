//
//  EmotionRecordAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import Swinject
import EmotionRecordInterface

public struct EmotionRecordAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(EmotionRecordBuildable.self) { _ in
            EmotionRecordBuilder()
        }
    }
    
}

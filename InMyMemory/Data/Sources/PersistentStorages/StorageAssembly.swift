//
//  StorageAssembly.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import Swinject
import SwiftData

public struct StorageAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SwiftDataStorageInterface.self) { _ in
            let schema: Schema = .init([EmotionModel.self, MemoryModel.self, TodoModel.self])
            return SwiftDataStorage(schema: schema)
        }
    }
    
}

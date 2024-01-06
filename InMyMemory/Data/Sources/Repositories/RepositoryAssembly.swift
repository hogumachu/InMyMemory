//
//  RepositoryAssembly.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import Interfaces
import PersistentStorages
import Swinject

public struct RepositoryAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        let storage = container.resolve(SwiftDataStorageInterface.self)!
        container.register(EmotionRepositoryInterface.self) { _ in
            EmotionRepository(storage: storage)
        }
        
        container.register(MemoryRepositoryInterface.self) { _ in
            MemoryRepository(storage: storage)
        }
        
        container.register(TodoRepositoryInterface.self) { _ in
            TodoRepository(storage: storage)
        }
    }
    
}

//
//  MemoryDetailAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import CoreKit
import Swinject
import MemoryDetailInterface

public struct MemoryDetailAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(MemoryDetailBuildable.self) { _ in
            MemoryDetailBuilder()
        }
    }
    
}

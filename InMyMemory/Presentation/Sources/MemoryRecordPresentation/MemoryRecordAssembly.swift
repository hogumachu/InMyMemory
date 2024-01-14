//
//  MemoryRecordAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import CoreKit
import Swinject
import MemoryRecordInterface

public struct MemoryRecordAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(MemoryRecordBuildable.self) { _ in
            MemoryRecordBuilder()
        }
    }
    
}

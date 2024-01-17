//
//  MemoryRecordBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import Entities
import MemoryRecordInterface

public final class MemoryRecordBuilder: MemoryRecordBuildable {
    
    public init() {}
    
    public func buildRecord(injector: DependencyInjectorInterface) -> Flow {
        return MemoryRecordFlow(injector: injector)
    }
    
    public func buildEdit(injector: DependencyInjectorInterface, memory: Memory) -> Flow {
        return MemoryEditFlow(injector: injector, memory: memory)
    }
    
}

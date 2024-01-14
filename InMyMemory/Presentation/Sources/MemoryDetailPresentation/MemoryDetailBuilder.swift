//
//  MemoryDetailBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import MemoryDetailInterface

public final class MemoryDetailBuilder: MemoryDetailBuildable {
    
    public init() {}
    
    public func build(memoryID: UUID, injector: DependencyInjectorInterface) -> Flow {
        return MemoryDetailFlow(memoryID: memoryID, injector: injector)
    }
    
}

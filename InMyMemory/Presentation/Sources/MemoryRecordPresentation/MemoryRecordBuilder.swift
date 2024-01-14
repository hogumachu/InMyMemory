//
//  MemoryRecordBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import MemoryRecordInterface

public final class MemoryRecordBuilder: MemoryRecordBuildable {
    
    public init() {}
    
    public  func build(injector: DependencyInjectorInterface) -> Flow {
        return MemoryRecordFlow(injector: injector)
    }
    
}

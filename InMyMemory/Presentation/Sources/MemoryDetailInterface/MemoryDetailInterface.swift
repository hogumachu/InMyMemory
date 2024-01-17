//
//  MemoryDetailInterface.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol MemoryDetailBuildable: AnyObject {
    func build(memoryID: UUID, injector: DependencyInjectorInterface) -> Flow
}

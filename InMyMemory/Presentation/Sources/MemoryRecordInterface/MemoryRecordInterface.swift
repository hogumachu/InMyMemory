//
//  MemoryRecordInterface.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol MemoryRecordBuildable: AnyObject {
    func build(injector: DependencyInjectorInterface) -> Flow
}

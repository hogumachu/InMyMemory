//
//  MemoryRecordInterface.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import Entities

public protocol MemoryRecordBuildable: AnyObject {
    func buildRecord(injector: DependencyInjectorInterface, date: Date) -> Flow
    func buildEdit(injector: DependencyInjectorInterface, memory: Memory) -> Flow
}

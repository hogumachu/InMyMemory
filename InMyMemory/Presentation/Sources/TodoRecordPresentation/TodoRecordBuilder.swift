//
//  TodoRecordBuilder.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import RxFlow
import CoreKit
import TodoRecordInterface

public final class TodoRecordBuilder: TodoRecordBuildable {
    
    public init() {}
    
    public func build(injector: DependencyInjectorInterface, date: Date) -> Flow {
        return TodoRecordFlow(injector: injector, date: date)
    }
    
}

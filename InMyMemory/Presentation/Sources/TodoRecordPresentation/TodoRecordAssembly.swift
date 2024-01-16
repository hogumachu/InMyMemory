//
//  TodoRecordAssembly.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import CoreKit
import Swinject
import TodoRecordInterface

public struct TodoRecordAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(TodoRecordBuildable.self) { _ in
            TodoRecordBuilder()
        }
    }
    
}

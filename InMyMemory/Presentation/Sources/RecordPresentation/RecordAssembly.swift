//
//  RecordAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import CoreKit
import Swinject
import RecordInterface

public struct RecordAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(RecordBuildable.self) { _ in
            RecordBuilder()
        }
    }
    
}

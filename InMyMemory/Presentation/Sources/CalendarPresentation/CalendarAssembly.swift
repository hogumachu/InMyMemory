//
//  CalendarAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import Swinject
import CalendarInterface

public struct CalendarAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CalendarBuildable.self) { _ in
            CalendarBuilder()
        }
    }
    
}

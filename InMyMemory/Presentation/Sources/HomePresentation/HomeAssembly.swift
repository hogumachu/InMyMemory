//
//  HomeAssembly.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import Swinject
import HomeInterface

public struct HomeAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(HomeBuildable.self) { _ in
            HomeBuilder()
        }
    }
    
}

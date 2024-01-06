//
//  UseCaseAssembly.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import CoreKit
import Interfaces
import Swinject

public struct UseCaseAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(HomeUseCaseInterface.self) { _ in
            HomeUseCase()
        }
    }
    
}

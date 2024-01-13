//
//  BasePresentationAssembly.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import Foundation
import CoreKit
import Swinject

public struct BasePresentationAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(PhotoProviderInterface.self) { _ in
            PhotoProvider()
        }
    }
    
}

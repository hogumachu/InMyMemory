//
//  DependencyInjector.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Swinject

public protocol DependencyInjectorInterface: AnyObject {
    func resolve<T>(_ serviceType: T.Type) -> T
    func register<T>(_ serviceType: T.Type, object: T)
    func assemble(_ assemblies: [Assembly])
}


public final class DependencyInjector: DependencyInjectorInterface {
    
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
    
    public func register<T>(_ serviceType: T.Type, object: T) {
        container.register(serviceType) { _ in object }
    }
    
    public func assemble(_ assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: container) }
    }
    
}

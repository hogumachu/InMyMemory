//
//  SearchFlow.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import RxFlow
import CoreKit

public final class SearchFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: SearchViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = SearchReactor()
        self.stepper = reactor
        self.rootViewController = SearchViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        return .none
    }
    
}

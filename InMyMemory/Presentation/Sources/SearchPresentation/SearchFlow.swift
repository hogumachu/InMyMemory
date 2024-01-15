//
//  SearchFlow.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import BasePresentation
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
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .searchIsRequired:
            return navigationToSearch()
            
        case .searchIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.searchIsComplete)
            
        default:
            return .none
        }
    }
    
    private func navigationToSearch() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
}

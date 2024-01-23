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
import Interfaces
import MemoryDetailInterface

public final class SearchFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: SearchViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = SearchReactor(useCase: injector.resolve(SearchUseCaseInterface.self))
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
            
        case .memoryDetailIsRequired(let memoryID):
            return navigationToMemoryDetail(memoryID: memoryID)
            
        case .memoryDetailIsComplete:
            return popMemoryDetail()
            
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
    
    private func navigationToMemoryDetail(memoryID: UUID) -> FlowContributors {
        let flow = injector.resolve(MemoryDetailBuildable.self).build(memoryID: memoryID, injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.memoryDetailIsRequired(memoryID))
        ))
    }
    
    private func popMemoryDetail() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        rootViewController.refresh()
        return .none
    }
    
}

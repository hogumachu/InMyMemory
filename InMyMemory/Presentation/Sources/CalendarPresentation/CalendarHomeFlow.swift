//
//  CalendarHomeFlow.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import SearchInterface
import RxSwift
import RxFlow

public final class CalendarHomeFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: CalendarHomeViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = CalendarHomeReactor(useCase: injector.resolve(CalendarUseCaseInterface.self))
        self.stepper = reactor
        self.rootViewController = CalendarHomeViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .calendarIsRequired:
            return navigationToCalendarHome()
            
        case .calendarIsComplete:
            return .end(forwardToParentFlowWithStep: appStep)
            
        case .searchIsRequired:
            return navigationToSearch()
            
        case .searchIsComplete:
            return popSearch()
            
        default:
            return .none
        }
    }
    
    private func navigationToCalendarHome() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToSearch() -> FlowContributors {
        let flow = injector.resolve(SearchBuildable.self).build(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.searchIsRequired)
        ))
    }
    
    private func popSearch() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    
}

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
import RxSwift
import RxFlow

public final class CalendarHomeFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: CalendarHomeViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = CalendarHomeReactor()
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
}

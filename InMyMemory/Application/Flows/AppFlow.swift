//
//  AppFlow.swift
//  InMyMemory
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxRelay
import RxFlow
import CoreKit
import Interfaces
import BasePresentation
import HomeInterface

final class AppFlow: Flow {
    
    public var root: Presentable { rootViewController }
    
    private lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .homeIsRequired:
            return navigationToHome()
            
        default:
            return .none
        }
    }
    
    private func navigationToHome() -> FlowContributors {
        let flow = injector.resolve(HomeBuildable.self).build(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: false)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)
        ))
    }
    
}

final class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    let initialStep: Step = AppStep.homeIsRequired
    
}

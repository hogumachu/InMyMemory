//
//  TodoRecordFlow.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxFlow

public final class TodoRecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: TodoRecordViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = TodoRecordReactor()
        self.stepper = reactor
        self.rootViewController = TodoRecordViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .todoRecordIsRequired:
            return navigationToTodoRecord()
            
        case .todoRecordIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.todoRecordIsComplete)
            
        case .todoTargetDateIsRequired(let todos):
            return navigationToTodoTargetDate(todos: todos)
            
        case .todoTargetDateIsComplete:
            return popTodoTargetDate()
            
        default:
            return .none
        }
    }
    
    private func navigationToTodoRecord() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToTodoTargetDate(todos: [String]) -> FlowContributors {
        let reactor = TodoTargetDateReactor(
            useCase: injector.resolve(TodoUseCaseInterface.self),
            todos: todos
        )
        let viewController = TodoTargetDateViewController()
        viewController.reactor = reactor
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
    private func popTodoTargetDate() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    
}

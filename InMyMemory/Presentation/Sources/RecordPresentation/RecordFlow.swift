//
//  RecordFlow.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxFlow
import CoreKit
import Interfaces
import BasePresentation
import EmotionRecordInterface
import MemoryRecordInterface
import TodoRecordInterface

public final class RecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: UINavigationController
    private let stepper: Stepper
    
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = RecordReactor()
        let viewController = RecordViewController()
        viewController.reactor = reactor
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        self.stepper = reactor
        self.rootViewController = navigationController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .recordIsRequired:
            return navigationToRecord()
            
        case .recordIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.recordIsComplete)
            
        case .emotionRecordIsRequired(let date):
            return navigationToEmotionRecord(date: date)
            
        case .emotionRecordIsComplete:
            return popEmotionRecord()
            
        case .memoryRecordIsRequired(let date):
            return navigationToMemoryRecord(date: date)
            
        case .memoryRecordIsComplete:
            return popMemoryRecord()
            
        case .memoryRecordCompleteIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.recordIsComplete)
            
        case .todoRecordIsRequired(let date):
            return navigationToTodoRecord(date: date)
            
        case .todoRecordIsComplete:
            return popTodoRecord()
            
        case .todoRecordCompleteIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.recordIsComplete)
            
        default:
            return .none
        }
    }
    
    private func navigationToRecord() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToEmotionRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(EmotionRecordBuildable.self).build(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.emotionRecordIsRequired(date))
        ))
    }
    
    private func navigationToMemoryRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(MemoryRecordBuildable.self).buildRecord(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.memoryRecordIsRequired(date))
        ))
    }
    
    private func navigationToTodoRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(TodoRecordBuildable.self).build(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.todoRecordIsRequired(date))
        ))
    }
    
    private func popEmotionRecord() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
    
    private func popMemoryRecord() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
    
    private func popTodoRecord() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
    
}

//
//  MemoryDetailFlow.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import MemoryRecordInterface
import RxSwift
import RxFlow

public final class MemoryDetailFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: MemoryDetailViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    private let memoryID: UUID
    
    public init(memoryID: UUID, injector: DependencyInjectorInterface) {
        self.injector = injector
        self.memoryID = memoryID
        let reactor = MemoryDetailReactor(
            memoryID: memoryID,
            useCase: injector.resolve(MemoryDetailUseCaseInterface.self)
        )
        self.stepper = reactor
        self.rootViewController = MemoryDetailViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .memoryDetailIsRequired:
            return navigationToMemoryDetail()
            
        case .memoryDetailIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryDetailIsComplete)
            
        case .memoryEditIsRequired(let memory):
            return navigationToMemoryEdit(memory: memory)
            
        case .memoryEditIsComplete:
            return dismissMemoryEdit()
            
        default:
            return .none
        }
    }
    
    private func navigationToMemoryDetail() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToMemoryEdit(memory: Memory) -> FlowContributors {
        let flow = injector.resolve(MemoryRecordBuildable.self).buildEdit(
            injector: injector, 
            memory: memory
        )
        Flows.use(flow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .overFullScreen
            self?.rootViewController.present(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.memoryEditIsRequired(memory))
        ))
    }
    
    private func dismissMemoryEdit() -> FlowContributors {
        if let editViewController = rootViewController.presentedViewController {
            editViewController.dismiss(
                animated: true,
                completion: { [weak self] in
                    self?.rootViewController.refresh()
                }
            )
        }
        return .none
    }
    
}

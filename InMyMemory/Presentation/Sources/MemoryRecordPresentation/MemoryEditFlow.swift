//
//  MemoryEditFlow.swift
//
//
//  Created by 홍성준 on 1/17/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxSwift
import RxFlow

public final class MemoryEditFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: UINavigationController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    private let photoProvider: PhotoProviderInterface
    private var photoProviderDelegate: PhotoProviderDelegate?
    private let memory: Memory
    
    public init(
        injector: DependencyInjectorInterface,
        memory: Memory
    ) {
        self.injector = injector
        self.memory = memory
        let reactor = MemoryRecordReactor(isPresent: true, memory: memory, date: memory.date)
        let viewController = MemoryRecordViewController()
        viewController.reactor = reactor
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        self.stepper = reactor
        self.rootViewController = navigationController
        self.photoProvider = injector.resolve(PhotoProviderInterface.self)
        self.photoProviderDelegate = viewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .memoryRecordIsRequired:
            return navigationToMemoryRecord()
            
        case .memoryRecordIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryEditIsComplete)
            
        case .memoryRecordPhotoIsRequired:
            return presentPhotoProvider()
            
        case .memoryRecordPhotoIsComplete:
            return dismissPhotoProvider()
            
        case .memoryRecordNoteIsRequired(let images, let date):
            return navigationToMemoryRecordNote(images: images, date: date)
            
        case .memoryRecordNoteIsComplete:
            return popMemoryRecordNote()
            
        case .memoryRecordCompleteIsRequired:
            return navigationToMemoryRecordComplete()
            
        case .memoryRecordCompleteIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryEditIsComplete)
            
        case .memoryEditIsRequired:
            return navigationToMemoryRecord()
            
        case .memoryEditIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryEditIsComplete)
            
        default:
            return .none
        }
    }
    
    private func navigationToMemoryRecord() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func presentPhotoProvider() -> FlowContributors {
        photoProvider.present(from: rootViewController, animated: true)
        photoProvider.delegate = photoProviderDelegate
        return .none
    }
    
    private func dismissPhotoProvider() -> FlowContributors {
        photoProvider.dismiss(animated: true)
        return .none
    }
    
    private func navigationToMemoryRecordNote(images: [Data], date: Date) -> FlowContributors {
        let reactor = MemoryRecordNoteReactor(
            memory: memory,
            images: images,
            date: date,
            useCase: injector.resolve(MemoryRecordUseCaseInterface.self)
        )
        let viewController = MemoryRecordNoteViewController()
        viewController.reactor = reactor
        rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
    private func popMemoryRecordNote() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
    
    private func navigationToMemoryRecordComplete() -> FlowContributors {
        let reactor = MemoryRecordCompleteReactor()
        let viewController = MemoryRecordCompleteViewController()
        viewController.reactor = reactor
        rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
}

//
//  MemoryRecordFlow.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxSwift
import RxFlow

public final class MemoryRecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: MemoryRecordViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    private let photoProvider: PhotoProviderInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = MemoryRecordReactor()
        self.stepper = reactor
        self.rootViewController = MemoryRecordViewController()
        self.rootViewController.reactor = reactor
        self.photoProvider = injector.resolve(PhotoProviderInterface.self)
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .memoryRecordIsRequired:
            return navigationToMemoryRecord()
            
        case .memoryRecordIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryRecordIsComplete)
            
        case .memoryRecordPhotoIsRequired:
            return presentPhotoProvider()
            
        case .memoryRecordPhotoIsComplete:
            return dismissPhotoProvider()
            
        case .memoryRecordNoteIsRequired(let images):
            return navigationToMemoryRecordNote(images: images)
            
        case .memoryRecordNoteIsComplete:
            return popMemoryRecordNote()
            
        case .memoryRecordCompleteIsRequired:
            return navigationToMemoryRecordComplete()
            
        case .memoryRecordCompleteIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.memoryRecordCompleteIsComplete)
            
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
        photoProvider.delegate = rootViewController
        return .none
    }
    
    private func dismissPhotoProvider() -> FlowContributors {
        photoProvider.dismiss(animated: true)
        return .none
    }
    
    private func navigationToMemoryRecordNote(images: [Data]) -> FlowContributors {
        let reactor = MemoryRecordNoteReactor(images: images)
        let viewController = MemoryRecordNoteViewController()
        viewController.reactor = reactor
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
    private func popMemoryRecordNote() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    
    private func navigationToMemoryRecordComplete() -> FlowContributors {
        let reactor = MemoryRecordCompleteReactor()
        let viewController = MemoryRecordCompleteViewController()
        viewController.reactor = reactor
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
}

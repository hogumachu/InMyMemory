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
    
}

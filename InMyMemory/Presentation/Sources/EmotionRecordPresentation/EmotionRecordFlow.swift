//
//  EmotionRecordFlow.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxSwift
import RxFlow

public final class EmotionRecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: EmotionRecordViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = EmotionRecordReactor(useCase: injector.resolve(EmotionRecordUseCaseInterface.self))
        self.stepper = reactor
        self.rootViewController = EmotionRecordViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .emotionRecordIsRequired:
            return navigationToEmotionRecord()
            
        case .emotionRecordIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.emotionRecordIsComplete)
            
        case .emotionRecordNoteIsRequired(let type):
            return navigationToEmotionRecordNote(emotionType: type)
            
        case .emotionRecordNoteIsComplete:
            return popEmotionRecordNote()
            
        case .emotionRecordCompleteIsRequired:
            return navigationToEmotionComplete()
            
        case .emotionRecordCompleteIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.recordIsComplete)
            
        default:
            return .none
        }
    }
    
    private func navigationToEmotionRecord() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToEmotionRecordNote(emotionType: EmotionType) -> FlowContributors {
        let viewController = EmotionRecordNoteViewController()
        let reactor = EmotionRecordNoteReactor(
            emotionType: emotionType,
            useCase: injector.resolve(EmotionRecordUseCaseInterface.self)
        )
        viewController.reactor = reactor
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
    private func popEmotionRecordNote() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    
    private func navigationToEmotionComplete() -> FlowContributors {
        let viewController = EmotionRecordCompleteViewController()
        let reactor = EmotionRecordCompleteReactor()
        viewController.reactor = reactor
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: reactor
        ))
    }
    
}

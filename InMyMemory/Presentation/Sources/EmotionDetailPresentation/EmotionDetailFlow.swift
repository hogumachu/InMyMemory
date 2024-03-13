//
//  EmotionDetailFlow.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import UIKit
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxSwift
import RxFlow

public final class EmotionDetailFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: EmotionDetailViewController
    private let stepper: Stepper
    private let injector: DependencyInjectorInterface
    
    public init(emotionID: UUID, injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = EmotionDetailReactor(emotionID: emotionID)
        self.stepper = reactor
        self.rootViewController = EmotionDetailViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .emotionDetailIsRequired:
            return navigationToEmotionDetail()
            
        case .emotionDetailIsComplete:
            return .end(forwardToParentFlowWithStep: AppStep.emotionDetailIsComplete)
            
        default:
            return .none
        }
    }
    
    private func navigationToEmotionDetail() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
}

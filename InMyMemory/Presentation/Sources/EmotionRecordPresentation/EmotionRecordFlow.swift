//
//  EmotionRecordFlow.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxFlow
import BasePresentation

public final class EmotionRecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: EmotionRecordViewController
    private let stepper: Stepper
    
    public init() {
        let reactor = EmotionRecordReactor()
        self.stepper = reactor
        self.rootViewController = EmotionRecordViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .emotionRecordIsRequired:
            return navigationToEmotionRecord()
            
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
    
}

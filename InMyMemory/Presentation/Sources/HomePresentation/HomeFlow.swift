//
//  HomeFlow.swift
//  InMyMemory
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxFlow
import BasePresentation
import EmotionRecordPresentation

public final class HomeFlow: Flow {
    
    public var root: Presentable { rootViewController }
    
    private let rootViewController: HomeViewController
    private let stepper: Stepper
    
    public init() {
        let reactor = HomeReactor()
        self.rootViewController = HomeViewController()
        rootViewController.reactor = reactor
        self.stepper = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .homeIsRequired:
            return navigationToHome()
            
        case .emotionRecordIsRequired:
            return navigationToEmotionRecord()
            
        default:
            return .none
        }
    }
    
    private func navigationToHome() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: stepper
        ))
    }
    
    private func navigationToEmotionRecord() -> FlowContributors {
        let flow = EmotionRecordFlow()
        Flows.use(flow, when: .created) { [weak self] root in
            guard let self else { return }
            rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.emotionRecordIsRequired)
        ))
    }
    
}

//
//  RecordFlow.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxFlow
import BasePresentation

public final class RecordFlow: Flow {
    
    public var root: Presentable { rootViewController }
    private let rootViewController: RecordViewController
    private let stepper: Stepper
    
    public init() {
        let reactor = RecordReactor()
        self.stepper = reactor
        self.rootViewController = RecordViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .recordIsRequired:
            return navigationToRecord()
            
        case .recordIsComplete:
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
    
}

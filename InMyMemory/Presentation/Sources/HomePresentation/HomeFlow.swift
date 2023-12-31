//
//  HomeFlow.swift
//  InMyMemory
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import RxSwift
import RxFlow
import CoreKit
import Interfaces
import BasePresentation
import RecordPresentation
import EmotionRecordPresentation
import CalendarPresentation

public final class HomeFlow: Flow {
    
    public var root: Presentable { rootViewController }
    
    private let rootViewController: HomeViewController
    private let stepper: Stepper
    
    private let injector: DependencyInjectorInterface
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = HomeReactor(useCase: injector.resolve(HomeUseCaseInterface.self))
        self.rootViewController = HomeViewController()
        rootViewController.reactor = reactor
        self.stepper = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .homeIsRequired:
            return navigationToHome()
            
        case .recordIsRequired:
            return navigationToRecord()
            
        case .recordIsComplete:
            return dismissRecord()
            
        case .emotionRecordIsRequired:
            return navigationToEmotionRecord()
            
        case .calendarIsRequired:
            return navigationToCalendarHome()
            
        case .calendarIsComplete:
            return popCalendarHome()
            
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
    
    private func navigationToRecord() -> FlowContributors {
        let flow = RecordFlow(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .overFullScreen
            self?.rootViewController.present(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.recordIsRequired)
        ))
    }
    
    private func navigationToEmotionRecord() -> FlowContributors {
        let flow = EmotionRecordFlow(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.emotionRecordIsRequired)
        ))
    }
    
    private func navigationToCalendarHome() -> FlowContributors {
        let flow = CalendarHomeFlow(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.calendarIsRequired)
        ))
    }
    
    private func dismissRecord() -> FlowContributors {
        if let recordViewController = self.rootViewController.presentedViewController {
            recordViewController.dismiss(animated: true)
        }
        return .none
    }
    
    private func popCalendarHome() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    
}

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
import RecordInterface
import EmotionRecordInterface
import CalendarInterface
import MemoryDetailInterface

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
            
        case .emotionRecordIsRequired(let date):
            return navigationToEmotionRecord(date: date)
            
        case .calendarIsRequired:
            return navigationToCalendarHome()
            
        case .calendarIsComplete:
            return popCalendarHome()
            
        case .memoryDetailIsRequired(let memoryID):
            return navigationToMemoryDetail(memoryID: memoryID)
            
        case .memoryDetailIsComplete:
            return popMemoryDetail()
            
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
        let flow = injector.resolve(RecordBuildable.self).build(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .overFullScreen
            self?.rootViewController.present(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.recordIsRequired)
        ))
    }
    
    private func navigationToEmotionRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(EmotionRecordBuildable.self).build(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.emotionRecordIsRequired(date))
        ))
    }
    
    private func navigationToCalendarHome() -> FlowContributors {
        let flow = injector.resolve(CalendarBuildable.self).build(injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.calendarIsRequired)
        ))
    }
    
    private func navigationToMemoryDetail(memoryID: UUID) -> FlowContributors {
        let flow = injector.resolve(MemoryDetailBuildable.self).build(memoryID: memoryID, injector: injector)
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.memoryDetailIsRequired(memoryID))
        ))
    }
    
    private func dismissRecord() -> FlowContributors {
        if let recordViewController = self.rootViewController.presentedViewController {
            recordViewController.dismiss(
                animated: true,
                completion: { [weak self] in
                    self?.rootViewController.refresh()
                }
            )
        }
        return .none
    }
    
    private func popCalendarHome() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        rootViewController.refresh()
        return .none
    }
    
    private func popMemoryDetail() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        rootViewController.refreshMemory()
        return .none
    }
    
}

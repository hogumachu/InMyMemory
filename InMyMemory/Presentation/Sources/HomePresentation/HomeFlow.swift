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
import MemoryRecordInterface
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
            
        case .recordIsRequired(let date):
            return navigationToRecord(date: date)
            
        case .recordIsComplete:
            return dismissRecord()
            
        case .emotionRecordIsRequired(let date):
            return navigationToEmotionRecord(date: date)
            
        case .emotionRecordIsComplete:
            return dismissEmotionRecord(isRefreshEnabled: false)
            
        case .emotionRecordCompleteIsComplete:
            return dismissEmotionRecord(isRefreshEnabled: true)
            
        case .calendarIsRequired:
            return navigationToCalendarHome()
            
        case .calendarIsComplete:
            return popCalendarHome()
            
        case .memoryRecordIsRequired(let date):
            return navigationToMemoryRecord(date: date)
            
        case .memoryRecordIsComplete:
            return dismissMemoryRecord(isRefreshEnabled: false)
            
        case .memoryRecordCompleteIsComplete:
            return dismissMemoryRecord(isRefreshEnabled: true)
            
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
    
    private func navigationToRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(RecordBuildable.self).build(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .overFullScreen
            self?.rootViewController.present(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.recordIsRequired(date))
        ))
    }
    
    private func navigationToEmotionRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(EmotionRecordBuildable.self).build(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            let navigationController = UINavigationController(rootViewController: root)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.setNavigationBarHidden(true, animated: false)
            self?.rootViewController.present(navigationController, animated: true)
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
    
    private func navigationToMemoryRecord(date: Date) -> FlowContributors {
        let flow = injector.resolve(MemoryRecordBuildable.self).buildRecord(injector: injector, date: date)
        Flows.use(flow, when: .created) { [weak self] root in
            let navigationController = UINavigationController(rootViewController: root)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.setNavigationBarHidden(true, animated: false)
            self?.rootViewController.present(navigationController, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: AppStep.memoryRecordIsRequired(date))
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
    
    private func dismissMemoryRecord(isRefreshEnabled: Bool) -> FlowContributors {
        if let recordViewController = self.rootViewController.presentedViewController {
            recordViewController.dismiss(
                animated: true,
                completion: { [weak self] in
                    if isRefreshEnabled {
                        self?.rootViewController.refresh()
                    }
                }
            )
        }
        return .none
    }
    
    private func dismissEmotionRecord(isRefreshEnabled: Bool) -> FlowContributors {
        if let recordViewController = self.rootViewController.presentedViewController {
            recordViewController.dismiss(
                animated: true,
                completion: { [weak self] in
                    if isRefreshEnabled {
                        self?.rootViewController.refresh()
                    }
                }
            )
        }
        return .none
    }
    
}

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
    
    public init(injector: DependencyInjectorInterface) {
        self.injector = injector
        let reactor = EmotionDetailReactor()
        self.stepper = reactor
        self.rootViewController = EmotionDetailViewController()
        self.rootViewController.reactor = reactor
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        return .none
    }
    
}

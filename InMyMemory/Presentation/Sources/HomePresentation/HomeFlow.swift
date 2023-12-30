//
//  HomeFlow.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import RxSwift
import RxFlow

public final class HomeFlow: Flow {
    
    public var root: Presentable { rootViewController }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = HomeViewController()
        viewController.reactor = HomeReactor()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    public init() {}
    
    public func navigate(to step: Step) -> FlowContributors {
        return .none
    }
    
}

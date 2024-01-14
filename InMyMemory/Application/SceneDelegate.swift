//
//  SceneDelegate.swift
//  InMyMemory
//
//  Created by 홍성준 on 12/29/23.
//

import UIKit
import RxSwift
import RxFlow
import CoreKit
import PersistentStorages
import Repositories
import UseCases
import BasePresentation
import CalendarPresentation
import RecordPresentation
import MemoryDetailPresentation
import MemoryRecordPresentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let coordinator = FlowCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let flow = AppFlow(injector: makeDependencyInjecter())
        coordinator.coordinate(flow: flow, with: AppStepper())
        Flows.use(flow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
    }
    
    private func makeDependencyInjecter() -> DependencyInjectorInterface {
        let injector = DependencyInjector(container: .init())
        injector.assemble([
            StorageAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            BasePresentationAssembly(),
            CalendarAssembly(),
            RecordAssembly(),
            MemoryDetailAssembly(),
            MemoryRecordAssembly()
        ])
        return injector
    }
    
}


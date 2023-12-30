//
//  SceneDelegate.swift
//  InMyMemory
//
//  Created by 홍성준 on 12/29/23.
//

import UIKit
import RxSwift
import RxFlow
import HomePresentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let homeFlow = HomeFlow()
        
        Flows.use(homeFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
    }
    
}


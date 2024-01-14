//
//  HomeBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import HomeInterface

public final class HomeBuilder: HomeBuildable {
    
    public init() {}
    
    public func build(injector: DependencyInjectorInterface) -> Flow {
        return HomeFlow(injector: injector)
    }
    
}

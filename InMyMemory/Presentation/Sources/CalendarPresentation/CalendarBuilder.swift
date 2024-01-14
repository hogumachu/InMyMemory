//
//  CalendarBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import CalendarInterface

public final class CalendarBuilder: CalendarBuildable {
    
    public init() {}
    
    public func build(injector: DependencyInjectorInterface) -> Flow {
        return CalendarHomeFlow(injector: injector)
    }
    
}

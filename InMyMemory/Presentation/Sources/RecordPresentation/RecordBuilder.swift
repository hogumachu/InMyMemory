//
//  RecordBuilder.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit
import RecordInterface

public final class RecordBuilder: RecordBuildable {
    
    public init() {}
    
    public func build(injector: DependencyInjectorInterface, date: Date) -> Flow {
        return RecordFlow(injector: injector, date: date)
    }
    
}

//
//  EmotionRecordInterface.swift
//
//
//  Created by 홍성준 on 1/14/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol EmotionRecordBuildable: AnyObject {
    func build(injector: DependencyInjectorInterface, date: Date) -> Flow
}

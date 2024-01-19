//
//  TodoRecordInterface.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol TodoRecordBuildable: AnyObject {
    func build(injector: DependencyInjectorInterface, date: Date) -> Flow
}

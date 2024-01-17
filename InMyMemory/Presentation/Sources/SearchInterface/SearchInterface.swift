//
//  SearchInterface.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol SearchBuildable: AnyObject {
    func build(injector: DependencyInjectorInterface) -> Flow
}

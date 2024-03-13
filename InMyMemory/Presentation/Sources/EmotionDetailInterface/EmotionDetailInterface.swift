//
//  EmotionDetailInterface.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import RxFlow
import CoreKit

public protocol EmotionDetailBuildable: AnyObject {
    func build(injector: DependencyInjectorInterface) -> Flow
}

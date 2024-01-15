//
//  SearchAssembly.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import SearchInterface
import Swinject
import RxFlow
import CoreKit

public struct SearchAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SearchBuildable.self) { _ in
            SearchBuilder()
        }
    }
    
}

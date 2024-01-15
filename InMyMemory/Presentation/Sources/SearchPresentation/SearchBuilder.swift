//
//  SearchBuilder.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import SearchInterface
import RxFlow
import CoreKit

final class SearchBuilder: SearchBuildable {
    
    func build(injector: DependencyInjectorInterface) -> Flow {
        return SearchFlow(injector: injector)
    }
    
}

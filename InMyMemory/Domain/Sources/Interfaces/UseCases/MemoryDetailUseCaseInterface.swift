//
//  MemoryDetailUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import Foundation
import Entities
import RxSwift

public protocol MemoryDetailUseCaseInterface: AnyObject {
    
    func memory(id: UUID) -> Single<Memory?>
    
}

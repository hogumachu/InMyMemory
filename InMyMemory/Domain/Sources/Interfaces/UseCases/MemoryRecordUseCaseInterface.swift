//
//  MemoryRecordUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import Foundation
import Entities
import RxSwift

public protocol MemoryRecordUseCaseInterface: AnyObject {
    func createMemory(_ memory: Memory) -> Single<Void>
}

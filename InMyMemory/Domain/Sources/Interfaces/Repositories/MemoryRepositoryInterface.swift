//
//  MemoryRepositoryInterface.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import Entities
import RxSwift

public protocol MemoryRepositoryInterface: AnyObject {
    func create(memory: Memory) -> Single<Void>
    func read(memoryID: UUID) -> Single<Memory?>
    func read(greaterThan date: Date) -> Single<[Memory]>
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Memory]>
    func read(keyword: String) -> Single<[Memory]>
    func update(memory: Memory) -> Single<Void>
    func delete(memory: Memory) -> Single<Void>
    func delete(memoryID: UUID) -> Single<Void>
}

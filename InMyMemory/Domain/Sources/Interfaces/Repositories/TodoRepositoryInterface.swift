//
//  TodoRepositoryInterface.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import Entities
import RxSwift

public protocol TodoRepositoryInterface: AnyObject {
    func create(todo: Todo) -> Single<Void>
    func read(todoID: UUID) -> Single<Todo?>
    func read(greaterThan date: Date) -> Single<[Todo]>
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Todo]>
    func read(keyword: String) -> Single<[Todo]>
    func update(todo: Todo) -> Single<Void>
    func delete(todo: Todo) -> Single<Void>
}

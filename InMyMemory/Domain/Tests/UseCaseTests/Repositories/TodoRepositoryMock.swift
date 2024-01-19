//
//  TodoRepositoryMock.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

final class TodoRepositoryMock: TodoRepositoryInterface {
    
    init() {}
    
    var createTodoCallCount = 0
    var createTodoTodo: Todo?
    func create(todo: Todo) -> Single<Void> {
        createTodoCallCount += 1
        createTodoTodo = todo
        return .just(())
    }
    
    var readTodoIDCallCount = 0
    var readTodoIDTodoID: UUID?
    var readTodoIDTodo: Todo?
    func read(todoID: UUID) -> Single<Todo?> {
        readTodoIDCallCount += 1
        readTodoIDTodoID = todoID
        return .just(readTodoIDTodo)
    }
    
    var readGreaterThanCallCount = 0
    var readGreaterThanDate: Date?
    var readGreaterThanTodo: [Todo] = []
    func read(greaterThan date: Date) -> Single<[Todo]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanTodo)
    }
    
    var readGreaterOrEqualThanLessThanCallCount = 0
    var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    var readGreaterOrEqualThanLessThanLessDate: Date?
    var readGreaterOrEqualThanLessThanTodos: [Todo] = []
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Todo]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanTodos)
    }
    
    var readKeywordCallCount = 0
    var readKeywordKeyword: String?
    var readKeywordTodos: [Todo] = []
    func read(keyword: String) -> Single<[Todo]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordTodos)
    }
    
    var updateTodoCallCount = 0
    var updateTodoTodo: Todo?
    func update(todo: Todo) -> Single<Void> {
        updateTodoCallCount += 1
        updateTodoTodo = todo
        return .just(())
    }
    
    var deleteTodoCallCount = 0
    var deleteTodoTodo: Todo?
    func delete(todo: Todo) -> Single<Void> {
        deleteTodoCallCount += 1
        deleteTodoTodo = todo
        return .just(())
    }
    
}

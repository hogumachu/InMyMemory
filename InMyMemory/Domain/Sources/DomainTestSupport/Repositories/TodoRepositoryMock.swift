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

public final class TodoRepositoryMock: TodoRepositoryInterface {
    
    public init() {}
    
    public var createTodoCallCount = 0
    public var createTodoTodo: Todo?
    public func create(todo: Todo) -> Single<Void> {
        createTodoCallCount += 1
        createTodoTodo = todo
        return .just(())
    }
    
    public var readTodoIDCallCount = 0
    public var readTodoIDTodoID: UUID?
    public var readTodoIDTodo: Todo?
    public func read(todoID: UUID) -> Single<Todo?> {
        readTodoIDCallCount += 1
        readTodoIDTodoID = todoID
        return .just(readTodoIDTodo)
    }
    
    public var readGreaterThanCallCount = 0
    public var readGreaterThanDate: Date?
    public var readGreaterThanTodo: [Todo] = []
    public func read(greaterThan date: Date) -> Single<[Todo]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanTodo)
    }
    
    public var readGreaterOrEqualThanLessThanCallCount = 0
    public var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    public var readGreaterOrEqualThanLessThanLessDate: Date?
    public var readGreaterOrEqualThanLessThanTodos: [Todo] = []
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Todo]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanTodos)
    }
    
    public var readKeywordCallCount = 0
    public var readKeywordKeyword: String?
    public var readKeywordTodos: [Todo] = []
    public func read(keyword: String) -> Single<[Todo]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordTodos)
    }
    
    public var updateTodoCallCount = 0
    public var updateTodoTodo: Todo?
    public func update(todo: Todo) -> Single<Void> {
        updateTodoCallCount += 1
        updateTodoTodo = todo
        return .just(())
    }
    
    public var deleteTodoCallCount = 0
    public var deleteTodoTodo: Todo?
    public func delete(todo: Todo) -> Single<Void> {
        deleteTodoCallCount += 1
        deleteTodoTodo = todo
        return .just(())
    }
    
}

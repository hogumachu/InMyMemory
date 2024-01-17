//
//  TodoRepository.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import Entities
import Interfaces
import PersistentStorages
import RxSwift

public final class TodoRepository: TodoRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func create(todo: Todo) -> Single<Void> {
        let model = TodoModel(todo: todo)
        return storage.insert(model: model)
    }
    
    public func read(todoID: UUID) -> Single<Todo?> {
        let predicate: Predicate<TodoModel> = #Predicate { model in
            model.id == todoID
        }
        return storage.readOne(predicate: predicate)
            .map { $0?.toEntity() }
    }
    
    public func read(greaterThan date: Date) -> Single<[Todo]> {
        let predicate: Predicate<TodoModel> = #Predicate { model in
            model.date > date
        }
        let sortBy: SortDescriptor<TodoModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Todo]> {
        let predicate: Predicate<TodoModel> = #Predicate { model in
            return model.date >= greaterOrEqualDate && model.date < lessDate
        }
        let sortBy: SortDescriptor<TodoModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(keyword: String) -> Single<[Todo]> {
        let predicate: Predicate<TodoModel> = #Predicate { model in
            return model.note.contains(keyword)
        }
        let sortBy: SortDescriptor<TodoModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func update(todo: Todo) -> Single<Void> {
        let model = TodoModel(todo: todo)
        return storage.insert(model: model)
    }
    
    public func delete(todo: Todo) -> Single<Void> {
        let model = TodoModel(todo: todo)
        return storage.remove(model: model)
    }
    
}

//
//  MemoryRepository.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import Entities
import Interfaces
import PersistentStorages
import RxSwift

public final class MemoryRepository: MemoryRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func create(memory: Memory) -> Single<Void> {
        let model = MemoryModel(memory: memory)
        return storage.insert(model: model)
    }
    
    public func read(memoryID: UUID) -> Single<Memory?> {
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            model.id == memoryID
        }
        return storage.readOne(predicate: predicate)
            .map { $0?.toEntity() }
    }
    
    public func read(greaterThan date: Date) -> Single<[Memory]> {
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            model.date > date
        }
        let sortBy: SortDescriptor<MemoryModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Memory]> {
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            return model.date >= greaterOrEqualDate && model.date < lessDate
        }
        let sortBy: SortDescriptor<MemoryModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(keyword: String) -> Single<[Memory]> {
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            return model.note.contains(keyword)
        }
        let sortBy: SortDescriptor<MemoryModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func update(memory: Memory) -> Single<Void> {
        let memoryID = memory.id
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            return model.id == memoryID
        }
        let model = MemoryModel(memory: memory)
        return storage.upsert(model: model, predicate: predicate)
    }
    
    public func delete(memory: Memory) -> Single<Void> {
        let model = MemoryModel(memory: memory)
        return storage.remove(model: model)
    }
    
    public func delete(memoryID: UUID) -> Single<Void> {
        let predicate: Predicate<MemoryModel> = #Predicate { model in
            return model.id == memoryID
        }
        return storage.remove(model: MemoryModel.self, predicate: predicate)
    }
    
}

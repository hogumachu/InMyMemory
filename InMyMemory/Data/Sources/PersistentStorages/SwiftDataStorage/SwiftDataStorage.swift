//
//  SwiftDataStorage.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import SwiftData
import RxSwift

public enum SwiftDataStorageError: Error {
    case canceled
}

public protocol SwiftDataStorageInterface: AnyObject {
    
    func read<T: PersistentModel>(sortBy: [SortDescriptor<T>]) -> Single<[T]>
    func read<T: PersistentModel>(sortBy: [SortDescriptor<T>], limit: Int) -> Single<[T]>
    func read<T: PersistentModel>(predicate: Predicate<T>) -> Single<[T]>
    func read<T: PersistentModel>(predicate: Predicate<T>, sortBy: [SortDescriptor<T>]) -> Single<[T]>
    func readOne<T: PersistentModel>(predicate: Predicate<T>) -> Single<T?>
    func removeAll<T: PersistentModel>(model: T.Type) -> Single<Void>
    func remove<T: PersistentModel>(model: T) -> Single<Void>
    func remove<T: PersistentModel>(model: T.Type, predicate: Predicate<T>) -> Single<Void>
    func insert<T: PersistentModel>(model: T) -> Single<Void>
    func upsert<T: PersistentModel>(model: T, predicate: Predicate<T>) -> Single<Void>
    
}

open class SwiftDataStorage: SwiftDataStorageInterface {
    
    private let container: ModelContainer
    private let context: ModelContext
    
    public init(schema: Schema) {
        do {
            let container = try ModelContainer(for: schema)
            self.container = container
            self.context = ModelContext(container)
            self.context.autosaveEnabled = true
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    open func read<T: PersistentModel>(sortBy: [SortDescriptor<T>]) async throws -> [T] {
        let descriptor = FetchDescriptor(sortBy: sortBy)
        return try context.fetch(descriptor)
    }
    
    @MainActor
    open func read<T: PersistentModel>(sortBy: [SortDescriptor<T>], limit: Int) async throws -> [T]  {
        var descriptor = FetchDescriptor(sortBy: sortBy)
        descriptor.fetchLimit = limit
        return try context.fetch(descriptor)
    }
    
    @MainActor
    open func read<T: PersistentModel>(predicate: Predicate<T>) async throws -> [T] {
        let descriptor = FetchDescriptor(predicate: predicate)
        return try context.fetch(descriptor)
    }
    
    @MainActor
    open func read<T: PersistentModel>(predicate: Predicate<T>, sortBy: [SortDescriptor<T>]) async throws -> [T] {
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: sortBy)
        return try context.fetch(descriptor)
    }
    
    
    @MainActor
    open func readOne<T: PersistentModel>(predicate: Predicate<T>) async throws -> T? {
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
    
    @MainActor
    open func removeAll<T: PersistentModel>(model: T.Type) async throws {
        try context.delete(model: model)
    }
    
    @MainActor
    open func insert<T: PersistentModel>(model: T) async {
        context.insert(model)
    }
    
    @MainActor
    open func remove<T: PersistentModel>(model: T) async {
        context.delete(model)
    }
    
    @MainActor
    open func remove<T: PersistentModel>(model: T.Type, where predicate: Predicate<T>) async throws {
        try context.delete(model: model, where: predicate)
    }
    
    @MainActor
    open func upsert<T: PersistentModel>(model: T, where predicate: Predicate<T>) async throws {
        try await remove(model: T.self, where: predicate)
        context.insert(model)
    }
    
    open func read<T: PersistentModel>(sortBy: [SortDescriptor<T>]) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let models = try await read(sortBy: sortBy)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func read<T: PersistentModel>(sortBy: [SortDescriptor<T>], limit: Int) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let models = try await read(sortBy: sortBy, limit: limit)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func read<T: PersistentModel>(predicate: Predicate<T>) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let model = try await read(predicate: predicate)
                    single(.success(model))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func read<T: PersistentModel>(predicate: Predicate<T>, sortBy: [SortDescriptor<T>]) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let model = try await read(predicate: predicate, sortBy: sortBy)
                    single(.success(model))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func readOne<T: PersistentModel>(predicate: Predicate<T>) -> Single<T?> {
        return Single<T?>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let model = try await readOne(predicate: predicate)
                    single(.success(model))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func removeAll<T: PersistentModel>(model: T.Type) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    try await removeAll(model: model)
                    single(.success(()))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func insert<T: PersistentModel>(model: T) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                await insert(model: model)
                single(.success(()))
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func upsert<T: PersistentModel>(model: T, predicate: Predicate<T>) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    try await upsert(model: model, where: predicate)
                    single(.success(()))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func remove<T: PersistentModel>(model: T) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                await remove(model: model)
                single(.success(()))
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func remove<T: PersistentModel>(model: T.Type, predicate: Predicate<T>) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                try await remove(model: model, where: predicate)
                single(.success(()))
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}

//
//  EmotionRepository.swift
//
//
//  Created by 홍성준 on 12/31/23.
//

import Foundation
import Entities
import Interfaces
import PersistentStorages
import RxSwift

public final class EmotionRepository: EmotionRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func create(emotion: Emotion) -> Single<Void> {
        let model = EmotionModel(emotion: emotion)
        return storage.insert(model: model)
    }
    
    public func read(emotionID: UUID) -> Single<Emotion?> {
        let predicate: Predicate<EmotionModel> = #Predicate { model in
            model.id == emotionID
        }
        return storage.readOne(predicate: predicate)
            .map { $0?.toEntity() }
    }
    
    public func read(greaterThan date: Date) -> Single<[Emotion]> {
        let predicate: Predicate<EmotionModel> = #Predicate { model in
            model.date > date
        }
        let sortBy: SortDescriptor<EmotionModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Emotion]> {
        let predicate: Predicate<EmotionModel> = #Predicate { model in
            return model.date >= greaterOrEqualDate && model.date < lessDate
        }
        let sortBy: SortDescriptor<EmotionModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func read(keyword: String) -> Single<[Emotion]> {
        let predicate: Predicate<EmotionModel> = #Predicate { model in
            return model.note.contains(keyword)
        }
        let sortBy: SortDescriptor<EmotionModel> = .init(\.updatedAt, order: .forward)
        return storage.read(predicate: predicate, sortBy: [sortBy])
            .map { $0.map { $0.toEntity() }}
    }
    
    public func update(emotion: Emotion) -> Single<Void> {
        let model = EmotionModel(emotion: emotion)
        return storage.insert(model: model)
    }
    
    public func delete(emotion: Emotion) -> Single<Void> {
        let model = EmotionModel(emotion: emotion)
        return storage.remove(model: model)
    }
    
    public func delete(emotionID: UUID) -> Single<Void> {
        let predicate: Predicate<EmotionModel> = #Predicate { model in
            return model.id == emotionID
        }
        return storage.remove(model: EmotionModel.self, predicate: predicate)
    }
    
}

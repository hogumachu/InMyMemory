//
//  HomeUseCaesMock.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

public final class HomeUseCaesMock: HomeUseCaseInterface {
    
    public init() {}
    
    public var fetchLastSevenDaysMemoriesCallCount = 0
    public var fetchLastSevenDaysMemoriesMemories: [Memory] = []
    public func fetchLastSevenDaysMemories() -> Single<[Memory]> {
        fetchLastSevenDaysMemoriesCallCount += 1
        return .just(fetchLastSevenDaysMemoriesMemories)
    }
    
    public var fetchCurrentWeekTodosCallCount = 0
    public var fetchCurrentWeekTodosTodos: [Todo] = []
    public func fetchCurrentWeekTodos() -> Single<[Todo]> {
        fetchCurrentWeekTodosCallCount += 1
        return .just(fetchCurrentWeekTodosTodos)
    }
    
    public var fetchLastSevenDaysEmotionsCallCount = 0
    public var fetchLastSevenDaysEmotionsEmotions: [Emotion] = []
    public func fetchLastSevenDaysEmotions() -> RxSwift.Single<[Emotion]> {
        fetchLastSevenDaysEmotionsCallCount += 1
        return .just(fetchLastSevenDaysEmotionsEmotions)
    }
    
    public var updateTodotodoCallCount = 0
    public var updateTodotodoTodo: Todo?
    public func updateTodo(todo: Todo) -> Single<Void> {
        updateTodotodoCallCount += 1
        updateTodotodoTodo = todo
        return .just(())
    }
    
}

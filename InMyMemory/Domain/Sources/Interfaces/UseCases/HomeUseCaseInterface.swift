//
//  HomeUseCaseInterface.swift
//  
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import Entities
import RxSwift

public protocol HomeUseCaseInterface: AnyObject {
    func fetchLastSevenDaysMemories() -> Single<[Memory]>
    func fetchCurrentWeekTodos() -> Single<[Todo]>
    func fetchLastSevenDaysEmotions() -> Single<[Emotion]>
    func updateTodo(todo: Todo) -> Single<Void>
}

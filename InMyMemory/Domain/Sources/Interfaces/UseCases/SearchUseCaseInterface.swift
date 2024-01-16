//
//  SearchUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import Entities
import RxSwift

public protocol SearchUseCaseInterface: AnyObject {
    func fetchMemories(keyword: String) -> Single<[Memory]>
    func fetchTodos(keyword: String) -> Single<[Todo]>
    func fetchEmotions(keyword: String) -> Single<[Emotion]>
}

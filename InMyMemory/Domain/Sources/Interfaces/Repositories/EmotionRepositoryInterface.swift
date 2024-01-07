//
//  EmotionRepositoryInterface.swift
//
//
//  Created by 홍성준 on 12/31/23.
//

import Foundation
import Entities
import RxSwift

public protocol EmotionRepositoryInterface: AnyObject {
    func create(emotion: Emotion) -> Single<Void>
    func read(emotionID: UUID) -> Single<Emotion?>
    func read(greaterThan date: Date) -> Single<[Emotion]>
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Emotion]>
    func update(emotion: Emotion) -> Single<Void>
    func delete(emotion: Emotion) -> Single<Void>
}

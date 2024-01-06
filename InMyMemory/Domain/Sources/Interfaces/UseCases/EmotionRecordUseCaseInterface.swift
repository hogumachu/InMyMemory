//
//  EmotionRecordUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import RxSwift

public protocol EmotionRecordUseCaseInterface: AnyObject {
    func createEmotion(_ emotion: Emotion) -> Single<Void>
}

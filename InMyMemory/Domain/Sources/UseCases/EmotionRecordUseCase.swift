//
//  EmotionRecordUseCase.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class EmotionRecordUseCase: EmotionRecordUseCaseInterface {
    
    private let emotionRepository: EmotionRepositoryInterface
    
    public init(emotionRepository: EmotionRepositoryInterface) {
        self.emotionRepository = emotionRepository
    }
    
    public func createEmotion(_ emotion: Emotion) -> Single<Void> {
        return emotionRepository.create(emotion: emotion)
    }
    
}

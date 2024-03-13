//
//  EmotionDetailUseCase.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class EmotionDetailUseCase: EmotionDetailUseCaseInterface {
    
    private let emotionRepository: EmotionRepositoryInterface
    
    public init(emotionRepository: EmotionRepositoryInterface) {
        self.emotionRepository = emotionRepository
    }
    
    public func emotion(id: UUID) -> Single<Emotion?> {
        return emotionRepository.read(emotionID: id)
    }
    
    public func remove(emotionID: UUID) -> Single<Void> {
        return emotionRepository.delete(emotionID: emotionID)
    }
}

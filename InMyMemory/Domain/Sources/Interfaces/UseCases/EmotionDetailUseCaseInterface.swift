//
//  EmotionDetailUseCaseInterface.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import Entities
import RxSwift

public protocol EmotionDetailUseCaseInterface: AnyObject {
    
    func emotion(id: UUID) -> Single<Emotion?>
    func remove(emotionID: UUID) -> Single<Void>
    
}

//
//  AppStep.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import RxFlow
import Entities

public enum AppStep: Step {
    
    case homeIsRequired
    
    // record
    case recordIsRequired
    case recordIsComplete
    
    // emotionRecord
    case emotionRecordIsRequired
    case emotionRecordIsComplete
    case emotionRecordNoteIsRequired(EmotionType)
    case emotionRecordNoteIsComplete
    case emotionRecordCompleteIsRequired
    case emotionRecordCompleteIsComplete
    
    // memoryRecord
    case memoryRecordIsRequired
    case memoryRecordIsComplete
    case memoryRecordPhotoIsRequired
    case memoryRecordPhotoIsComplete
    case memoryRecordNoteIsRequired([Data])
    case memoryRecordNoteIsComplete
    case memoryRecordCompleteIsRequired
    case memoryRecordCompleteIsComplete
    
    // calendar
    case calendarIsRequired
    case calendarIsComplete
    
    // memoryDetail
    case memoryDetailIsRequired(UUID)
    case memoryDetailIsComplete
    
}

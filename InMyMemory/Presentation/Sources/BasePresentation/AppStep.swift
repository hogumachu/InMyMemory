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
    case recordIsRequired(Date)
    case recordIsComplete
    
    // emotionRecord
    case emotionRecordIsRequired(Date)
    case emotionRecordIsComplete
    case emotionRecordNoteIsRequired(EmotionType, Date)
    case emotionRecordNoteIsComplete
    case emotionRecordCompleteIsRequired
    case emotionRecordCompleteIsComplete
    
    // memoryRecord
    case memoryRecordIsRequired(Date)
    case memoryRecordIsComplete
    case memoryRecordPhotoIsRequired
    case memoryRecordPhotoIsComplete
    case memoryRecordNoteIsRequired([Data], Date)
    case memoryRecordNoteIsComplete
    case memoryRecordCompleteIsRequired
    case memoryRecordCompleteIsComplete
    
    // todoRecord
    case todoRecordIsRequired(Date)
    case todoRecordIsComplete
    case todoTargetDateIsRequired([String], Date)
    case todoTargetDateIsComplete
    case todoRecordCompleteIsRequired
    case todoRecordCompleteIsComplete
    
    // calendar
    case calendarIsRequired
    case calendarIsComplete
    
    // emotionDetail
    case emotionDetailIsRequired(UUID)
    case emotionDetailIsComplete
    
    // memoryDetail
    case memoryDetailIsRequired(UUID)
    case memoryDetailIsComplete
    
    // memoryEdit
    case memoryEditIsRequired(Memory)
    case memoryEditIsComplete
    
    // search
    case searchIsRequired
    case searchIsComplete
    
}

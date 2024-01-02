//
//  AppStep.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

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
    
}

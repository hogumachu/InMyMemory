//
//  AppStep.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import RxFlow

public enum AppStep: Step {
    
    case homeIsRequired
    
    // record
    case recordIsRequired
    case recordIsComplete
    
    // emotionRecord
    case emotionRecordIsRequired
    case emotionRecordIsComplete
    
}

//
//  MemoryRecordReactor.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class MemoryRecordReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    struct State {
        
    }
    
    enum Mutation {
        
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
}
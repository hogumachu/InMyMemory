//
//  HomeReactor.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import RxSwift
import ReactorKit

enum HomeAction {
    
}

struct HomeState {
    
}

final class HomeReactor: Reactor {
    
    typealias Action = HomeAction
    typealias State = HomeState
    
    var initialState: HomeState = .init()
    
}

//
//  TodoUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import Entities
import RxSwift

public protocol TodoUseCaseInterface: AnyObject {
    func fetchDaysInMonth(year: Int, month: Int) -> Single<[Day]>
    func createTodo(_ todo: Todo) -> Single<Void>
}

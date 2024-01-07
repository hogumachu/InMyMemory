//
//  CalendarUseCaseInterface.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import RxSwift

public protocol CalendarUseCaseInterface: AnyObject {
    func fetchDaysInMonth(year: Int, month: Int) -> Single<[Day]>
}

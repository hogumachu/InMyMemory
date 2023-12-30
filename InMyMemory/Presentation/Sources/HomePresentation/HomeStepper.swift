//
//  HomeStepper.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import RxFlow
import RxSwift
import RxRelay

public final class HomeStepper: Stepper {
    
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    public init() {}
    
}

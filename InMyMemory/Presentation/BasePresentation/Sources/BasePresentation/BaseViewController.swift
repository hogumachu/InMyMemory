//
//  BaseViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import RxSwift
import ReactorKit

open class BaseViewController<ReactorType: Reactor>: UIViewController, View {
    
    public typealias Reactor = ReactorType
    
    public var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
    }
    
    public func setupLayout() {}
    public func setupAttributes() {}
    public func bind(reactor: ReactorType) {}
    
}

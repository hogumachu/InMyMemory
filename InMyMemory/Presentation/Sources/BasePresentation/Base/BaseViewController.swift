//
//  BaseViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import RxSwift
import ReactorKit

public protocol Refreshable: AnyObject {
    func refresh()
}

open class BaseViewController<ReactorType: Reactor>: UIViewController, Refreshable, View {
    
    public typealias Reactor = ReactorType
    
    public var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func bind(reactor: ReactorType) {}
    open func refresh() {}
    
}

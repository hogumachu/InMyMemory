//
//  EmptyBaseViewController.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import RxSwift

open class EmptyBaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func bind() {}
    
}

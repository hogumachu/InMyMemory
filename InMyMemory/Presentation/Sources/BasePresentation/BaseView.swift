//
//  BaseView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import RxSwift

open class BaseView: UIView {
    
    public let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
        bind()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
        bind()
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func bind() {}
    
}

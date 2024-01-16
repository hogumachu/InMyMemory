//
//  LoadingView.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import DesignKit
import SnapKit
import Then
import RxSwift

open class LoadingView: BaseView {
    
    public var isLoading: Binder<Bool> {
        return Binder(self) { this, isLoading in
            isLoading ? this.showLoading() : this.hideLoading()
        }
    }
    
    private let indicator = UIActivityIndicatorView()
    
    open func showLoading() {
        indicator.startAnimating()
        isHidden = false
    }
    
    open func hideLoading() {
        indicator.stopAnimating()
        isHidden = true
    }
    
    open override func setupLayout() {
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    open override func setupAttributes() {
        backgroundColor = .reverseBackground.withAlphaComponent(0.3)
        
        indicator.do {
            $0.color = .background
        }
    }
    
}

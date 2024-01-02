//
//  RecordViewController.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import ReactorKit
import Then
import SnapKit

final class RecordViewController: BaseViewController<RecordReactor> {
    
    private let navigationView = NavigationView()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .close, rightButtonTypes: []))
        }
    }
    
    override func bind(reactor: RecordReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}

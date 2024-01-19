//
//  MemoryHomeTodoView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

struct MemoryHomeTodoViewModel {
    let items: [MemoryHomeTodoContentViewModel]
}

final class MemoryHomeTodoView: BaseView {
    
    private let titleView = HomeTitleView()
    private let stackView = UIStackView()
    fileprivate let tapRelay = PublishRelay<UUID>()
    
    func setup(model: MemoryHomeTodoViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.items.forEach { item in
            let view = MemoryHomeTodoContentView()
            view.layer.cornerRadius = 20
            view.setup(model: item)
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
            view.rx.recognizedTap
                .map { item.id }
                .bind(to: tapRelay)
                .disposed(by: disposeBag)
        }
    }
    
    override func setupLayout() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleView.do {
            $0.title = "이번주 할 일 "
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
    }
    
}

extension Reactive where Base: MemoryHomeTodoView {
    
    var todoID: ControlEvent<UUID> {
        let source = base.tapRelay
        return ControlEvent(events: source)
    }
    
}

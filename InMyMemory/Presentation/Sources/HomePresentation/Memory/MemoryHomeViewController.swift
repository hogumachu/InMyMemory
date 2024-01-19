//
//  MemoryHomeViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

final class MemoryHomeViewController: UIViewController {
    
    var pastWeekViewModelBinder: Binder<MemoryHomePastWeekViewModel> {
        return Binder(self) { this, viewModel in
            this.pastWeekView.setup(model: viewModel)
        }
    }
    
    var todoViewModelBinder: Binder<MemoryHomeTodoViewModel> {
        return Binder(self) { this, viewModel in
            this.todoView.setup(model: viewModel)
        }
    }
    
    fileprivate let detailTapRelay = PublishRelay<UUID>()
    fileprivate let todoTapRelay = PublishRelay<UUID>()
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    fileprivate let recordView = MemoryHomeRecordView()
    private let pastWeekView = MemoryHomePastWeekView()
    private let todoView = MemoryHomeTodoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
        bind()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(recordView)
        stackView.addArrangedSubview(pastWeekView)
        stackView.addArrangedSubview(todoView)
    }
    
    private func setupAttributes() {
        view.backgroundColor = .background
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = .init(
                top: 40,
                left: 0,
                bottom: 40,
                right: 0
            )
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 40
        }
    }
    
    private func bind() {
        pastWeekView.rx.detailID
            .bind(to: detailTapRelay)
            .disposed(by: disposeBag)
        
        todoView.rx.todoID
            .bind(to: todoTapRelay)
            .disposed(by: disposeBag)
    }
    
}

extension Reactive where Base: MemoryHomeViewController {
    
    var detailID: ControlEvent<UUID> {
        let source = base.detailTapRelay
        return ControlEvent(events: source)
    }
    
    var todoID: ControlEvent<UUID> {
        let source = base.todoTapRelay
        return ControlEvent(events: source)
    }
    
    var recordTap: ControlEvent<Void> {
        return base.recordView.rx.recordTap
    }
    
}

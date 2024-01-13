//
//  MemoryDetailViewController.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import UIKit
import CoreKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import ReactorKit
import Then
import SnapKit

struct MemoryDetailViewModel {
    let date: String
    let note: String
    let images: [Data]
}

final class MemoryDetailViewController: BaseViewController<MemoryDetailReactor> {
    
    private let navigationView = NavigationView()
    private let scrollView = UIScrollView()
    private let imageListView = MemoryDetailImageListView()
    private let dateLabel = UILabel()
    private let noteLabel = UILabel()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(imageListView)
        imageListView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(view)
        }
        
        scrollView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageListView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        scrollView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        dateLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        noteLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
    override func bind(reactor: MemoryDetailReactor) {
        rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.viewModel)
            .map(\.images)
            .bind(to: imageListView.rx.images)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.viewModel)
            .map(\.date)
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.viewModel)
            .map(\.note)
            .bind(to: noteLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

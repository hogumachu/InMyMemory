//
//  MemoryRecordViewController.swift
//
//
//  Created by 홍성준 on 1/12/24.
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

final class MemoryRecordViewController: BaseViewController<MemoryRecordReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let photoView = MemoryRecordPhotoView()
    private let nextButton = ActionButton()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "저장할 사진이 있나요?"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
            $0.numberOfLines = 0
        }
        
        nextButton.do {
            $0.style = .normal
            $0.setTitle("다음", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    override func bind(reactor: MemoryRecordReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: MemoryRecordReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        photoView.rx.addTap
            .map { Reactor.Action.addDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        photoView.rx.removeImageTap
            .map { Reactor.Action.imageRemoveDidTap($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.nextDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: MemoryRecordReactor) {
        reactor.state.map(\.title)
            .bind(to: photoView.rx.title)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.images)
            .bind(to: photoView.rx.images)
            .disposed(by: disposeBag)
    }
    
}

extension MemoryRecordViewController: PhotoProviderDelegate {
    
    func photoProviderDidFinishPicking(_ provider: PhotoProviderInterface, image: Data?) {
        reactor?.action.onNext(.imageDidTap(image))
    }
    
}

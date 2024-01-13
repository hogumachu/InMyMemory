//
//  MemoryRecordNoteViewController.swift
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

final class MemoryRecordNoteViewController: BaseViewController<MemoryRecordNoteReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let noteView = UITextView()
    private let nextButton = ActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTraitChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteView.becomeFirstResponder()
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
            make.height.equalTo(50)
        }
        
        view.addSubview(noteView)
        noteView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(nextButton.snp.top).offset(-15)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "이 날 어떠셨나요?"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
            $0.numberOfLines = 0
        }
        
        noteView.do {
            $0.font = .gmarketSans(type: .light, size: 17)
            $0.textColor = .orange1
            $0.backgroundColor = .background
            $0.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
            $0.textContainerInset = .init(top: 0, left: 20, bottom: 0, right: 20)
            $0.showsVerticalScrollIndicator = false
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
        }
        
        nextButton.do {
            $0.style = .normal
            $0.setTitle("다음", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    override func bind(reactor: MemoryRecordNoteReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        noteView.rx.text
            .map { Reactor.Action.textDidUpdated($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.nextDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isEnabled)
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.noteView.layer.borderColor = UIColor.orange1.cgColor
        }
    }
    
}

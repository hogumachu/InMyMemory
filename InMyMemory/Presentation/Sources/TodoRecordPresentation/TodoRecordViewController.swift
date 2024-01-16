//
//  TodoRecordViewController.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import CoreKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxDataSources
import ReactorKit
import Then
import SnapKit

final class TodoRecordViewController: BaseViewController<TodoRecordReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeCollectionViewLayout()
    )
    private let todoInputView = TodoRecordInputView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        todoInputView.becomeFirstResponder()
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
        
        view.addSubview(todoInputView)
        todoInputView.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(todoInputView.snp.top)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "할일을 추가해주세요"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
        }
        
        collectionView.do {
            $0.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
            $0.showsVerticalScrollIndicator = false
            $0.register(TodoRecordTodoCell.self)
        }
    }
    
    override func bind(reactor: TodoRecordReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: TodoRecordReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        todoInputView.rx.returnDidTap
            .bind(to: returnBinder)
            .disposed(by: disposeBag)
        
        todoInputView.rx.removeDidTap
            .subscribe(
                with: todoInputView,
                onNext: { this, _ in this.clear() }
            )
            .disposed(by: disposeBag)
        
        todoInputView.rx.text
            .map { !($0?.isEmpty ?? true) }
            .bind(to: todoInputView.isClearEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: TodoRecordReactor) {
        reactor.state.map(\.todos)
            .bind(to: collectionView.rx.items) { collectionView, row, todo in
                let cell = collectionView.dequeue(TodoRecordTodoCell.self, for: IndexPath(row: row, section: 0))
                cell.setup(todo: todo)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private var returnBinder: Binder<String> {
        return Binder(self) { this, todo in
            this.reactor?.action.onNext(.todoUpdated(todo))
            this.todoInputView.clear()
        }
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .none
            configuration.backgroundColor = .background
            configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                return self?.makeSwipeActions(for: indexPath)
            }
            configuration.showsSeparators = true
            configuration.itemSeparatorHandler = { indexPath, separatorConfiguration in
                var config = separatorConfiguration
                config.topSeparatorVisibility = indexPath.row == 0 ? .hidden : .visible
                config.bottomSeparatorVisibility = .hidden
                config.color = .orange2
                config.topSeparatorInsets = .zero
                return config
            }
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 0
            section.contentInsets = .zero
            return section
        }
    }
    
    private func makeSwipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let deleteAction = UIContextualAction(style: .destructive, title: "제거") { [weak self] _, _, completion in
            self?.reactor?.action.onNext(.todoRemoved(indexPath))
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

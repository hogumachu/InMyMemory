//
//  SearchViewController.swift
//
//
//  Created by 홍성준 on 1/15/24.
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

final class SearchViewController: BaseViewController<SearchReactor> {
    
    private let navigationView = NavigationView()
    private let searchInputView = SearchInputView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    private let loadingView = LoadingView()
    private let emptyLabel = UILabel()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(searchInputView)
        searchInputView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchInputView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(searchInputView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        collectionView.do {
            $0.register(SearchResultEmotionCell.self)
            $0.register(SearchResultMemoryCell.self)
            $0.register(SearchResultTodoCell.self)
            $0.registerHeader(TextOnlyCollectionHeaderView.self)
        }
        
        loadingView.do {
            $0.isHidden = true
        }
        
        emptyLabel.do {
            $0.text = "검색 결과가 없어요"
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .medium, size: 17)
            $0.textAlignment = .center
            $0.isHidden = true
        }
    }
    
    override func bind(reactor: SearchReactor) {
        bindAction(reactor)
        bindState(reactor)
        bindETC(reactor)
    }
    
    private func bindAction(_ reactor: SearchReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchInputView.rx.searchDidTap
            .map { Reactor.Action.search($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { Reactor.Action.itemDidTap($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: SearchReactor) {
        reactor.state.map(\.sections)
            .bind(to: collectionView.rx.items(dataSource: makeDataSource()))
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isLoading)
            .bind(to: loadingView.isLoading)
            .disposed(by: disposeBag)
        
        reactor.state.map { !$0.isEmpty }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func bindETC(_ reactor: SearchReactor) {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .background
            configuration.headerTopPadding = 20
            configuration.showsSeparators = false
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
    }
    
    private func makeDataSource() -> RxCollectionViewSectionedReloadDataSource<SearchSection> {
        return .init(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .emotion(let model):
                    let cell = collectionView.dequeue(SearchResultEmotionCell.self, for: indexPath)
                    cell.setup(model: model)
                    return cell
                    
                case .memory(let model):
                    let cell = collectionView.dequeue(SearchResultMemoryCell.self, for: indexPath)
                    cell.setup(model: model)
                    return cell
                    
                case .todo(let model):
                    let cell = collectionView.dequeue(SearchResultTodoCell.self, for: indexPath)
                    cell.setup(model: model)
                    return cell
                }
            },
            configureSupplementaryView: { dataSource, collectionView, title, indexPath in
                let header = collectionView.dequeueHeader(TextOnlyCollectionHeaderView.self, for: indexPath)
                header.updateTitle(dataSource[indexPath.section].header)
                return header
            }
        )
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}

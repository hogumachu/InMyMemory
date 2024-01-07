//
//  CalendarListViewController.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import CoreKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import ReactorKit
import Then
import SnapKit

final class CalendarListViewController: EmptyBaseViewController {
    
    private var sections: [CalendarListSection] = []
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    fileprivate var sectionBinder: Binder<[CalendarListSection]> {
        return Binder(self) { this, sections in
            this.setup(sections: sections)
        }
    }
    
    func setup(sections: [CalendarListSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(CalendarTodoListCell.self)
            $0.register(CalendarMemoryListCell.self)
            $0.register(CalendarEmotionListCell.self)
            $0.registerHeader(TextOnlyCollectionHeaderView.self)
        }
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
    
}

extension CalendarListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension CalendarListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        switch item {
        case .todo(let model):
            let cell = collectionView.dequeue(CalendarTodoListCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .emotion(let model):
            let cell = collectionView.dequeue(CalendarEmotionListCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .memory(let model):
            let cell = collectionView.dequeue(CalendarMemoryListCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let title = sections[safe: indexPath.section]?.title,
              kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueHeader(TextOnlyCollectionHeaderView.self, for: indexPath)
        header.updateTitle(title)
        return header
    }
    
}

extension Reactive where Base: CalendarListViewController {
    
    var sections: Binder<[CalendarListSection]> {
        return base.sectionBinder
    }
    
}

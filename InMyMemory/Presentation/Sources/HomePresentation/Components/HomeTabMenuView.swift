//
//  HomeTabMenuView.swift
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

final class HomeTabMenuView: UIView {
    
    enum State {
        case selected
        case deselected
        
        var color: UIColor {
            switch self {
            case .selected: return .orange1
            case .deselected: return .orange2
            }
        }
        
        var font: UIFont {
            switch self {
            case .selected: return .gmarketSans(type: .bold, size: 27)
            case .deselected: return .gmarketSans(type: .medium, size: 27)
            }
        }
    }
    
    fileprivate let buttonTapRelay = PublishRelay<Int>()
    private var tapBinder: Binder<Int> {
        return Binder(self) { this, index in
            this.buttonTapRelay.accept(index)
        }
    }
    
    private var menus: [UIButton] = []
    private let disposeBag = DisposeBag()
    
    func selectMenu(at index: Int) {
        guard menus.indices ~= index else { return }
        menus.enumerated()
            .forEach { offset, button in
                let color: UIColor = offset == index ? State.selected.color : State.deselected.color
                let font: UIFont = offset == index ? State.selected.font : State.deselected.font
                button.setTitleColor(color, for: .normal)
                button.titleLabel?.font = font
            }
        
        layoutIfNeeded()
    }
    
    func configure(titles: [String]) {
        let buttons = titles.map { title in
            return UIButton().with {
                $0.setTitleColor(.orange2, for: .normal)
                $0.titleLabel?.font = State.deselected.font
                $0.setTitle(title, for: .normal)
            }
        }
        menus = buttons
        setupLayout(menus: buttons)
        setupTap(menus: buttons)
        selectMenu(at: 0)
    }
    
    private func setupLayout(menus: [UIButton]) {
        subviews.forEach { $0.removeFromSuperview() }
        
        menus.enumerated()
            .forEach { offset, button in
                addSubview(button)
                button.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    if offset == 0 {
                        make.leading.equalToSuperview().offset(20)
                    } else {
                        make.leading.equalTo(menus[offset - 1].snp.trailing).offset(20)
                    }
                }
            }
    }
    
    private func setupTap(menus: [UIButton]) {
        menus.enumerated()
            .forEach { offset, button in
                button.rx.tap
                    .map { _ in offset }
                    .bind(to: tapBinder)
                    .disposed(by: disposeBag)
            }
    }
    
}

extension Reactive where Base: HomeTabMenuView {
    
    var menuDidTap: ControlEvent<Int> {
        let source = base.buttonTapRelay.asObservable()
        return ControlEvent(events: source)
    }
    
}

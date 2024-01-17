//
//  NavigationView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

public struct NavigationViewModel {
    
    let leftButtonType: NavigationViewLeftButtonType
    let rightButtonTypes: [NavigationViewRightButtonType]
    
    public init(leftButtonType: NavigationViewLeftButtonType, rightButtonTypes: [NavigationViewRightButtonType]) {
        self.leftButtonType = leftButtonType
        self.rightButtonTypes = rightButtonTypes
    }
    
}

public final class NavigationView: UIView {
    
    public var leftButtonType: Binder<NavigationViewLeftButtonType> {
        return Binder(self) { this, type in
            this.leftButton.type = type
        }
    }
    
    fileprivate let leftButton = NavigationViewLeftButton()
    private let rightButtonStackView = UIStackView()
    private let disposeBag = DisposeBag()
    
    fileprivate let rightButtonTapRelay = PublishRelay<NavigationViewRightButtonType>()
    
    private var rightButtonBinder: Binder<NavigationViewRightButtonType> {
        return Binder(self) { this, type in
            this.rightButtonTapRelay.accept(type)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttributes()
        setupLayout()
    }
    
    public func setup(model: NavigationViewModel) {
        leftButton.type = model.leftButtonType
        rightButtonStackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.rightButtonTypes
            .forEach { type in
                NavigationViewRightButton().do {
                    $0.type = type
                    $0.tintColor = .orange1
                    $0.contentMode = .center
                    $0.rx.tap
                        .map { _ in type }
                        .bind(to: rightButtonBinder)
                        .disposed(by: disposeBag)
                    $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
                    rightButtonStackView.addArrangedSubview($0)
                }
            }
    }
    
    private func setupLayout() {
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(rightButtonStackView)
        rightButtonStackView.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        backgroundColor = .background
        
        leftButton.do {
            $0.tintColor = .orange1
            $0.contentMode = .center
        }
        
        rightButtonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .trailing
            $0.spacing = 3
        }
    }
    
}

public extension Reactive where Base: NavigationView {
    
    var leftButtonDidTap: ControlEvent<Void> {
        let source = base.leftButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var rightButtonDidTap: ControlEvent<NavigationViewRightButtonType> {
        let source = base.rightButtonTapRelay.asObservable()
        return ControlEvent(events: source)
    }
    
}

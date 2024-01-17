//
//  EmotionHomeGraphView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

struct EmotionHomeGraphViewModel {
    let items: [EmotionHomeGraphBarViewModel]
}

final class EmotionHomeGraphView: BaseView {
    
    private let titleView = HomeTitleView()
    fileprivate let informationImageView = UIImageView()
    private let stackView = UIStackView()
    private let separator = UIView()
    
    func setup(model: EmotionHomeGraphViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.items.forEach { item in
            let view = EmotionHomeGraphBarView()
            view.setup(model: item)
            stackView.addArrangedSubview(view)
        }
    }
    
    override func setupLayout() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(informationImageView)
        informationImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleView.snp.trailing).offset(10)
            make.centerY.equalTo(titleView)
            make.size.equalTo(20)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.centerX.bottom.equalToSuperview()
        }
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(stackView).offset(EmotionHomeGraphBarView.barHeight)
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(1)
        }
    }
    
    override func setupAttributes() {
        titleView.do {
            $0.title = "감정 그래프"
        }
        
        informationImageView.do {
            $0.image = .informationCircle.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .orange1
            $0.contentMode = .scaleAspectFit
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        
        separator.do {
            $0.backgroundColor = .orange1
        }
    }
    
}

extension Reactive where Base: EmotionHomeGraphView {
    
    var informationTap: ControlEvent<Void> {
        let source = base.informationImageView.rx.recognizedTap
        return ControlEvent(events: source)
    }
    
}

//
//  MemoryHomePastWeekView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct MemoryHomePastWeekViewModel {
    let items: [MemoryHomePastWeekContentViewModel]
}

final class MemoryHomePastWeekView: BaseView {
    
    private let titleView = MemoryHomeTitleView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let emptyLabel = UILabel()
    
    func setup(model: MemoryHomePastWeekViewModel) {
        emptyLabel.isHidden = !model.items.isEmpty
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.items.forEach { item in
            let view = MemoryHomePastWeekContentView()
            view.setup(model: item)
            stackView.addArrangedSubview(view)
        }
    }
    
    override func setupLayout() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(130)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleView.do {
            $0.title = "최근 7일간의 기억"
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = .init(
                top: 0,
                left: 20,
                bottom: 0,
                right: 20
            )
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
        
        emptyLabel.do {
            $0.text = "저장된 기억이 없어요"
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 21)
        }
    }
    
}

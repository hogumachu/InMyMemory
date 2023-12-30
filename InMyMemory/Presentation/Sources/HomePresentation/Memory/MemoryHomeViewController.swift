//
//  MemoryHomeViewController.swift
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

final class MemoryHomeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let recordView = MemoryHomeRecordView()
    private let pastWeekView = MemoryHomePastWeekView()
    private let todoView = MemoryHomeTodoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(recordView)
        stackView.addArrangedSubview(pastWeekView)
        stackView.addArrangedSubview(todoView)
    }
    
    private func setupAttributes() {
        view.backgroundColor = .background
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = .init(
                top: 40,
                left: 0,
                bottom: 40,
                right: 0
            )
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 40
        }
        
        todoView.do {
            $0.setup(model: .init(items: [
                .init(todo: "In My Memory 와이어프레임 및 디자인 완성하기", isChecked: false),
                .init(todo: "우유 사오기", isChecked: true),
                .init(todo: "볼펜 심 사오기 (하이테크 0.5mm)", isChecked: false),
                .init(todo: "홍삼 주문하기", isChecked: false),
            ]))
        }
    }
    
}

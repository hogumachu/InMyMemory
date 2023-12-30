//
//  EmotionHomeViewController.swift
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

final class EmotionHomeViewController: UIViewController {
    
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let recordView = EmotionHomeRecordView()
    private let pastWeekView = EmotionHomePastWeekView()
    
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
        
        pastWeekView.do {
            $0.setup(model: .init(items: [
                .init(score: 7, emotion: "좋아요"),
                .init(score: 10, emotion: "그냥 그래요"),
                .init(score: 3, emotion: "나빠요"),
            ]))
        }
    }
    
}

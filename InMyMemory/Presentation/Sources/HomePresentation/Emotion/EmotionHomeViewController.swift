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
    private let graphView = EmotionHomeGraphView()
    
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
        stackView.addArrangedSubview(graphView)
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
        
        graphView.do {
            $0.setup(model: .init(items: [
                .init(rate: 1.0, date: "23일"),
                .init(rate: -0.2, date: "24일"),
                .init(rate: -0.3, date: "25일"),
                .init(rate: 0.5, date: "26일"),
                .init(rate: -1.0, date: "27일"),
                .init(rate: 0.7, date: "28일"),
                .init(rate: 0.6, date: "29일"),
            ]))
        }
    }
    
}

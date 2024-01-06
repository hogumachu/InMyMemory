//
//  EmotionHomeViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class EmotionHomeViewController: UIViewController {
    
    var emotionBinder: Binder<[Emotion]> {
        return Binder(self) { this, emotions in
            this.updateEmotions(emotions)
        }
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let recordView = EmotionHomeRecordView()
    private let pastWeekView = EmotionHomePastWeekView()
    fileprivate let graphView = EmotionHomeGraphView()
    
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
    }
    
    private func updateEmotions(_ emotions: [Emotion]) {
        let pastWeekViewModel = makePastWeekViewModel(emotions)
        let graphViewModel = makeGraphViewModel(emotions)
        pastWeekView.setup(model: pastWeekViewModel)
        graphView.setup(model: graphViewModel)
    }
    
    private func makePastWeekViewModel(_ emotions: [Emotion]) -> EmotionHomePastWeekViewModel {
        let goodScore = emotions.filter { $0.emotionType == .good }.count
        let sosoScore = emotions.filter { $0.emotionType == .soso }.count
        let badScore = emotions.filter { $0.emotionType == .bad }.count
        
        return .init(items: [
            .init(score: goodScore, emotion: "좋아요"),
            .init(score: sosoScore, emotion: "그냥 그래요"),
            .init(score: badScore, emotion: "나빠요")
        ])
    }
    
    private func makeGraphViewModel(_ emotions: [Emotion]) -> EmotionHomeGraphViewModel {
        let items: [EmotionHomeGraphBarViewModel] = emotions.map { emotion in
            return .init(rate: 0, date: "X일")
        }
        return .init(items: items)
    }
    
}

extension Reactive where Base: EmotionHomeViewController {
    
    var informationTap: ControlEvent<Void> {
        let source = base.graphView.rx.informationTap
        return ControlEvent(events: source)
    }
    
}

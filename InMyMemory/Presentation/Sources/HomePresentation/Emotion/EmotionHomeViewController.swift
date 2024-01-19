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

struct EmotionHomeViewModel {
    let pastWeekViewModel: EmotionHomePastWeekViewModel
    let graphViewModel: EmotionHomeGraphViewModel
}

final class EmotionHomeViewController: UIViewController {
    
    var viewModelBinder: Binder<EmotionHomeViewModel> {
        return Binder(self) { this, viewModel in
            this.pastWeekView.setup(model: viewModel.pastWeekViewModel)
            this.graphView.setup(model: viewModel.graphViewModel)
        }
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    fileprivate let recordView = EmotionHomeRecordView()
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
    
}

extension Reactive where Base: EmotionHomeViewController {
    
    var recordTap: ControlEvent<Void> {
        return base.recordView.rx.recordTap
    }
    
    var informationTap: ControlEvent<Void> {
        let source = base.graphView.rx.informationTap
        return ControlEvent(events: source)
    }
    
}

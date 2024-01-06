//
//  MemoryHomeViewController.swift
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

struct MemoryHomeViewModel {
    let pastWeekViewModel: MemoryHomePastWeekViewModel
    let todoViewModel: MemoryHomeTodoViewModel
}

final class MemoryHomeViewController: UIViewController {
    
    var viewModelBinder: Binder<MemoryHomeViewModel> {
        return Binder(self) { this, viewModel in
            this.pastWeekView.setup(model: viewModel.pastWeekViewModel)
            this.todoView.setup(model: viewModel.todoViewModel)
        }
    }
    
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
    }
    
}

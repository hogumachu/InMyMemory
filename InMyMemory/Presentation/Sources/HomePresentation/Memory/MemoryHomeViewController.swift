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

final class MemoryHomeViewController: UIViewController {
    
    var memoryBinder: Binder<[Memory]> {
        return Binder(self) { this, memories in
            this.updateMemories(memories)
        }
    }
    
    var todoBinder: Binder<[Todo]> {
        return Binder(self) { this, todos in
            this.updateTodos(todos)
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
    
    private func updateMemories(_ memories: [Memory]) {
        let viewModel = makeWeekViewModel(memories)
        pastWeekView.setup(model: viewModel)
    }
    
    private func updateTodos(_ todos: [Todo]) {
        let viewModel = makeTodoViewModel(todos)
        todoView.setup(model: viewModel)
    }
    
    private func makeWeekViewModel(_ memories: [Memory]) -> MemoryHomePastWeekViewModel {
        let items: [MemoryHomePastWeekContentViewModel] = memories.prefix(10).map {
            .init(title: $0.note, imageData: $0.images.first)
        }
        return .init(items: items)
    }
    
    private func makeTodoViewModel(_ todos: [Todo]) -> MemoryHomeTodoViewModel {
        let items: [MemoryHomeTodoContentViewModel] = todos.prefix(10).map {
            .init(todo: $0.note, isChecked: $0.isCompleted)
        }
        return .init(items: items)
    }
    
}

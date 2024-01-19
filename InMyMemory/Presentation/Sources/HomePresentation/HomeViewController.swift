//
//  HomeViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import ReactorKit
import Then
import SnapKit

final class HomeViewController: BaseViewController<HomeReactor> {
    
    private var currentPage = 0
    
    private let tabMenuView = HomeTabMenuView()
    private let sideView = HomeSideView()
    private let emotionGraphInformationView = EmotionHomeGraphInformationView()
    
    private let memoryViewController = MemoryHomeViewController()
    private let emotionViewController = EmotionHomeViewController()
    
    private var pageViewControllers: [UIViewController] {
        return [memoryViewController, emotionViewController]
    }
    
    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    func refreshEmotion() {
        reactor?.action.onNext(.refreshEmotion)
    }
    
    func refreshMemory() {
        reactor?.action.onNext(.refreshMemory)
    }
    
    override func setupLayout() {
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        view.addSubview(tabMenuView)
        tabMenuView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tabMenuView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(sideView)
        sideView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(emotionGraphInformationView)
        emotionGraphInformationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        tabMenuView.do {
            $0.configure(titles: ["기억", "감정"])
            $0.backgroundColor = .background
        }
        
        pageViewController.do {
            $0.delegate = self
            $0.dataSource = self
            $0.setViewControllers([memoryViewController], direction: .forward, animated: true)
        }
    }
    
    override func bind(reactor: HomeReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    override func refresh() {
        reactor?.action.onNext(.refresh)
    }
    
    private func bindAction(_ reactor: Reactor) {
        rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tabMenuView.rx.menuDidTap
            .bind(to: menuTapBinder)
            .disposed(by: disposeBag)
        
        sideView.rx.calendarDidTap
            .map { Reactor.Action.calendarDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sideView.rx.recordDidTap
            .map { Reactor.Action.recordDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emotionViewController.rx.informationTap
            .bind(to: emotionInformationTapBinder)
            .disposed(by: disposeBag)
        
        emotionViewController.rx.recordTap
            .map { Reactor.Action.emotionRecordDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memoryViewController.rx.detailID
            .map(Reactor.Action.memoryDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memoryViewController.rx.todoID
            .map(Reactor.Action.todoDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memoryViewController.rx.recordTap
            .map { Reactor.Action.memoryRecordDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.compactMap(\.emotionViewModel)
            .bind(to: emotionViewController.viewModelBinder)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.memoryPastWeekViewModel)
            .bind(to: memoryViewController.pastWeekViewModelBinder)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.todoViewModel)
            .bind(to: memoryViewController.todoViewModelBinder)
            .disposed(by: disposeBag)
    }
    
    private var menuTapBinder: Binder<Int> {
        return Binder(self) { this, index in
            guard this.currentPage != index,
                  this.pageViewControllers.indices ~= index,
                  let viewController = this.pageViewControllers[safe: index]
            else {
                return
            }
            
            this.pageViewController.setViewControllers(
                [viewController],
                direction: this.currentPage < index ? .forward : .reverse,
                animated: true
            )
            this.currentPage = index
            this.tabMenuView.selectMenu(at: index)
        }
    }
    
    private var emotionInformationTapBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.emotionGraphInformationView.showWithAnimation()
        }
    }
    
}

extension HomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let lastViewController = pageViewController.viewControllers?.first,
              let index = pageViewControllers.firstIndex(of: lastViewController) else {
            return
        }
        tabMenuView.selectMenu(at: index)
        currentPage = index
    }
    
}

extension HomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController) else { return nil }
        guard index > 0 else { return nil }
        return pageViewControllers[safe: index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController) else { return nil }
        guard index < pageViewControllers.count - 1 else { return nil }
        return pageViewControllers[safe: index + 1]
    }
    
}

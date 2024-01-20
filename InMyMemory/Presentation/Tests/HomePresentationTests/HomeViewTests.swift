//
//  HomeViewTests.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

@testable import HomePresentation
import HomeTestSupport
import PresentationTestSupport
import DomainTestSupport
import Entities
import Interfaces
import UseCases
import CoreKit
import BasePresentation
import XCTest
import SnapshotTesting
import ReactorKit
import RxSwift

final class HomeViewTests: XCTestCase {
    
    private var useCase: HomeUseCaseInterface!
    private var emotionRepository: EmotionRepositoryMock!
    private var memoryRepository: MemoryRepositoryMock!
    private var todoRepository: TodoRepositoryMock!
    
    override func setUp() {
        super.setUp()
        emotionRepository = .init()
        memoryRepository = .init()
        todoRepository = .init()
        useCase = HomeUseCase(
            emotionRepository: emotionRepository,
            memoryRepository: memoryRepository,
            todoRepository: todoRepository
        )
    }
    
    func test_데이터_없을_때_화면() {
        // given
        let reactor = HomeReactor(useCase: useCase)
        let sut = HomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_메모리_데이터가_있을_때_화면() {
        // given
        let reactor = HomeReactor(useCase: useCase)
        let sut = HomeViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            memoryPastWeekViewModel: .init(items: [
                .init(id: .init(), title: "Test Memory 1", imageData: nil),
                .init(id: .init(), title: "Test Memory 2", imageData: nil),
                .init(id: .init(), title: "Test Memory 3", imageData: nil),
                .init(id: .init(), title: "Test Memory 4", imageData: nil),
            ])
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_할일_데이터가_있을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 12, day: 25)!
        let reactor = HomeReactor(useCase: useCase)
        let sut = HomeViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            todoViewModel: .init(items: [
                .init(id: .init(), todo: "Test Todo 1", isChecked: true, date: date),
                .init(id: .init(), todo: "Test Todo 2", isChecked: false, date: date),
                .init(id: .init(), todo: "Test Todo 3", isChecked: true, date: date),
                .init(id: .init(), todo: "Test Todo 4", isChecked: false, date: date)
            ])
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_로딩_화면() {
        // given
        let reactor = HomeReactor(useCase: useCase)
        let sut = HomeViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: true
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    private func makeDate(year: Int, month: Int, day: Int) -> Date? {
        return Calendar.current.date(from: .init(
            year: year,
            month: month,
            day: day
        ))
    }
    
}

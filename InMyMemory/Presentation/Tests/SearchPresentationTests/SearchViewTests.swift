//
//  SearchViewTests.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

@testable import SearchPresentation
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

final class SearchViewTests: XCTestCase {
    
    private var useCase: SearchUseCaseInterface!
    private var emotionRepository: EmotionRepositoryMock!
    private var memoryRepository: MemoryRepositoryMock!
    private var todoRepository: TodoRepositoryMock!
    
    override func setUp() {
        super.setUp()
        emotionRepository = .init()
        memoryRepository = .init()
        todoRepository = .init()
        useCase = SearchUseCase(
            emotionRepository: emotionRepository,
            memoryRepository: memoryRepository,
            todoRepository: todoRepository
        )
    }
    
    func test_초기_진입_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_검색_결과가_없을_때_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            isEmpty: true,
            sections: []
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_감정_데이터가_있을_때_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            isEmpty: true,
            sections: [
                .init(
                    original: .emotion([
                        .emotion(.init(id: .init(), type: .bad, note: "Emotion 1", date: "2024-01-03")),
                        .emotion(.init(id: .init(), type: .good, note: "Emotion 2", date: "2024-01-04")),
                        .emotion(.init(id: .init(), type: .soso, note: "Emotion 3", date: "2024-01-05")),
                    ]),
                    items: []
                )
            ]
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_기억_데이터가_있을_때_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            isEmpty: true,
            sections: [
                .init(
                    original: .memory([
                        .memory(.init(id: .init(), note: "Memory 1", imagteData: nil, date: "2024-01-03")),
                        .memory(.init(id: .init(), note: "Memory 2", imagteData: nil, date: "2024-01-04")),
                        .memory(.init(id: .init(), note: "Memory 3", imagteData: nil, date: "2024-01-05")),
                        .memory(.init(id: .init(), note: "Memory 4", imagteData: nil, date: "2024-01-06")),
                    ]),
                    items: []
                )
            ]
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_할일_데이터가_있을_때_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: false,
            isEmpty: true,
            sections: [
                .init(
                    original: .todo([
                        .todo(.init(id: .init(), note: "Todo 1", isCompleted: false, date: "2024-01-03")),
                        .todo(.init(id: .init(), note: "Todo 2", isCompleted: true, date: "2024-01-04")),
                        .todo(.init(id: .init(), note: "Todo 3", isCompleted: false, date: "2024-01-05")),
                    ]),
                    items: []
                )
            ]
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_로딩_화면() {
        // given
        let reactor = SearchReactor(useCase: useCase)
        let sut = SearchViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isLoading: true,
            isEmpty: true,
            sections: []
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

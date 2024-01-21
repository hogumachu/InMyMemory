//
//  TodoRecordViewTests.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

@testable import TodoRecordPresentation
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

final class TodoRecordViewTests: XCTestCase {
    
    private var useCase: TodoUseCaseInterface!
    private var repository: TodoRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = TodoUseCase(todoRepository: repository)
    }
    
    func test_viewDidLoad_되었을_때_화면() {
        // given
        let date: Date = .init()
        let reactor = TodoRecordReactor(date: date)
        let sut = TodoRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_isEnabled_true_화면() {
        // given
        let date: Date = .init()
        let reactor = TodoRecordReactor(date: date)
        let sut = TodoRecordViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(isEnabled: true)
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_todo_데이터가_있을_때_화면() {
        // given
        let date: Date = .init()
        let reactor = TodoRecordReactor(date: date)
        let sut = TodoRecordViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(todos: [
            "Todo 1",
            "Todo 2",
            "Todo 3",
        ])
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

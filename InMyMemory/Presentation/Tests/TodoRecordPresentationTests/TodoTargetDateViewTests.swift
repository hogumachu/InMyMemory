//
//  TodoTargetDateViewTests.swift
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

final class TodoTargetDateViewTests: XCTestCase {
    
    private var useCase: TodoUseCaseInterface!
    private var repository: TodoRepositoryMock!
    private var dateFactory: DateFactory!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        dateFactory = .init()
        useCase = TodoUseCase(todoRepository: repository)
    }
    
    func test_2023년1월1일_화면() throws {
        // given
        let date = try XCTUnwrap(dateFactory.makeDate(year: 2023, month: 1, day: 1))
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: date)
        let sut = TodoTargetDateViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_1999년12월25일_화면() throws {
        // given
        let date = try XCTUnwrap(dateFactory.makeDate(year: 1999, month: 12, day: 25))
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: date)
        let sut = TodoTargetDateViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_1999년12월25일_7일_선택되었을_때_화면() throws {
        // given
        let date = try XCTUnwrap(dateFactory.makeDate(year: 1999, month: 12, day: 25))
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: date)
        let sut = TodoTargetDateViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.dayDidTap(7))
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_1999년12월25일에서_다음달로_넘어간_화면() throws {
        // given
        let date = try XCTUnwrap(dateFactory.makeDate(year: 1999, month: 12, day: 25))
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: date)
        let sut = TodoTargetDateViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.monthRightDidTap)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_1999년12월25일에서_이전달로_넘어간_화면() throws {
        // given
        let date = try XCTUnwrap(dateFactory.makeDate(year: 1999, month: 12, day: 25))
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: date)
        let sut = TodoTargetDateViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.monthLeftDidTap)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_로딩_화면() {
        // given
        let reactor = TodoTargetDateReactor(useCase: useCase, todos: [], date: .init())
        let sut = TodoTargetDateViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(date: .init(), monthTitle: "Loading Test", isLoading: true)
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

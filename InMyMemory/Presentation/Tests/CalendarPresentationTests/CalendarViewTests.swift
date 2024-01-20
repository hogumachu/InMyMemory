//
//  CalendarViewTests.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

@testable import CalendarPresentation
import CalendarTestSupport
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

final class CalendarViewTests: XCTestCase {
    
    private var useCase: CalendarUseCaseInterface!
    private var emotionRepository: EmotionRepositoryMock!
    private var memoryRepository: MemoryRepositoryMock!
    private var todoRepository: TodoRepositoryMock!
    
    override func setUp() {
        super.setUp()
        emotionRepository = .init()
        memoryRepository = .init()
        todoRepository = .init()
        useCase = CalendarUseCase(
            emotionRepository: emotionRepository,
            memoryRepository: memoryRepository,
            todoRepository: todoRepository
        )
    }
    
    func test_2023년12월25일_데이터_없을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 12, day: 25)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_2024년1월4일_데이터_없을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_감정기록_데이터_있을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        emotionRepository.readGreaterOrEqualThanLessThanEmotions = [
            .init(id: .init(), note: "Emotion Note1", emotionType: .good, date: date),
            .init(id: .init(), note: "Emotion Note2", emotionType: .soso, date: date),
            .init(id: .init(), note: "Emotion Note3", emotionType: .bad, date: date)
        ]
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_기억기록_데이터_있을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        memoryRepository.readGreaterOrEqualThanLessThanMemories = [
            .init(images: [], note: "Memory Note1", date: date),
            .init(images: [], note: "Memory Note2", date: date),
            .init(images: [], note: "Memory Note3", date: date)
        ]
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_할일기록_데이터_있을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        todoRepository.readGreaterOrEqualThanLessThanTodos = [
            .init(id: .init(), note: "Todo Note1", isCompleted: false, date: date),
            .init(id: .init(), note: "Todo Note2", isCompleted: true, date: date),
            .init(id: .init(), note: "Todo Note3", isCompleted: false, date: date)
        ]
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이전_달로_이동하는_버튼_눌렀을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.monthLeftDidTap)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_다음_달로_이동하는_버튼_눌렀을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.monthRightDidTap)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_날짜_10일을_눌렀을_때_화면() {
        // given
        let date = makeDate(year: 2023, month: 1, day: 4)!
        let reactor = CalendarHomeReactor(useCase: useCase, date: date)
        let sut = CalendarHomeViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.dayDidTap(10))
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    private func makeDate(year: Int, month: Int, day: Int) -> Date? {
        return Calendar.current.date(from: .init(year: year, month: month, day: day))
    }
    
}

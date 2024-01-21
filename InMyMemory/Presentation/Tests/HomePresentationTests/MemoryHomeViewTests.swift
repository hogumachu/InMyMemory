//
//  MemoryHomeViewTests.swift
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

final class MemoryHomeViewTests: XCTestCase {
    
    private var dateFactory: DateFactory!
    
    override func setUp() {
        super.setUp()
        dateFactory = .init()
    }
    
    func test_데이터_없을_때_화면() {
        // given
        let sut = MemoryHomeViewController()
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_기억_데이터_있을_때_화면() {
        // given
        let sut = MemoryHomeViewController()
        let viewModel: MemoryHomePastWeekViewModel = .init(items: [
            .init(id: .init(), title: "Test 1", imageData: nil),
            .init(id: .init(), title: "Test 2", imageData: nil),
            .init(id: .init(), title: "Test 3", imageData: nil),
            .init(id: .init(), title: "Test 4", imageData: nil),
        ])
        
        // when
        sut.viewDidLoad()
        sut.pastWeekViewModelBinder.onNext(viewModel)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_할일_데이터_있을_때_화면() {
        // given
        let date = dateFactory.makeDate(year: 2023, month: 12, day: 25)!
        let sut = MemoryHomeViewController()
        let viewModel: MemoryHomeTodoViewModel = .init(items: [
            .init(id: .init(), todo: "Test 1", isChecked: true, date: date),
            .init(id: .init(), todo: "Test 2", isChecked: false, date: date),
            .init(id: .init(), todo: "Test 3", isChecked: true, date: date),
            .init(id: .init(), todo: "Test 4", isChecked: false, date: date),
        ])
        // when
        sut.viewDidLoad()
        sut.todoViewModelBinder.onNext(viewModel)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

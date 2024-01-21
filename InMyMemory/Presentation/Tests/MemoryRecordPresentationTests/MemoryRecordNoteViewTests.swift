//
//  MemoryRecordNoteViewTests.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

@testable import MemoryRecordPresentation
import MemoryRecordTestSupport
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

final class MemoryRecordNoteViewTests: XCTestCase {
    
    private var useCase: MemoryRecordUseCaseInterface!
    private var repository: MemoryRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = MemoryRecordUseCase(memoryRepository: repository)
    }
    
    func test_Memory가_없을_때_화면() {
        // given
        let reactor = MemoryRecordNoteReactor(
            memory: nil,
            images: [],
            date: .init(),
            useCase: useCase
        )
        let sut = MemoryRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_Memory가_있을_때_화면() {
        // given
        let reactor = MemoryRecordNoteReactor(
            memory: Memory.init(images: [], note: "Test Note 1", date: .init()),
            images: [],
            date: .init(),
            useCase: useCase
        )
        let sut = MemoryRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_Memory가_없고_Text가_입력된_후_화면() {
        // given
        let reactor = MemoryRecordNoteReactor(
            memory: nil,
            images: [],
            date: .init(),
            useCase: useCase
        )
        let sut = MemoryRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        reactor.action.onNext(.textDidUpdated("Test Note 2"))
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

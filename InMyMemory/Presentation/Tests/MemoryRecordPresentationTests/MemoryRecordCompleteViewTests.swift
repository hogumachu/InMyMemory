//
//  MemoryRecordCompleteViewTests.swift
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

final class MemoryRecordCompleteViewTests: XCTestCase {
    
    private var useCase: MemoryRecordUseCaseInterface!
    private var repository: MemoryRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = MemoryRecordUseCase(memoryRepository: repository)
    }
    
    func test_기억기록완료_화면() {
        // given
        let reactor = MemoryRecordCompleteReactor()
        let sut = MemoryRecordCompleteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

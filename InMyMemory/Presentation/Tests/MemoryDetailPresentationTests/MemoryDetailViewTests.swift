//
//  MemoryDetailViewTests.swift
//  
//
//  Created by 홍성준 on 1/20/24.
//

@testable import MemoryDetailPresentation
import MemoryDetailTestSupport
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

final class MemoryDetailViewTests: XCTestCase {
    
    private var useCase: MemoryDetailUseCaseInterface!
    private var repository: MemoryRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = MemoryDetailUseCase(memoryRepository: repository)
    }
    
    func test_데이터_없을_때_화면() {
        // given
        let reactor = MemoryDetailReactor(memoryID: .init(), useCase: useCase)
        let sut = MemoryDetailViewController()
        sut.reactor = reactor
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_데이터_있을_때_화면() {
        // given
        let reactor = MemoryDetailReactor(memoryID: .init(), useCase: useCase)
        let sut = MemoryDetailViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            viewModel: MemoryDetailViewModel(date: "2024년 01월 17일 수요일", note: "Test Memory Detail Note", images: []),
            isLoading: false
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이미지_데이터_있을_때_화면() {
        // given
        let imageData = UIImage.checkCircle.pngData()!
        let reactor = MemoryDetailReactor(memoryID: .init(), useCase: useCase)
        let sut = MemoryDetailViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            viewModel: MemoryDetailViewModel(date: "2024년 01월 17일 수요일", note: "Test Memory Detail Note", images: [imageData]),
            isLoading: false
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_로딩_화면() {
        // given
        let reactor = MemoryDetailReactor(memoryID: .init(), useCase: useCase)
        let sut = MemoryDetailViewController()
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
    
}

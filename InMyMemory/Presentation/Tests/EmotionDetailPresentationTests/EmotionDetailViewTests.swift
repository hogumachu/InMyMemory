//
//  EmotionDetailViewTests.swift
//
//
//  Created by 홍성준 on 3/14/24.
//

@testable import EmotionDetailPresentation
import EmotionDetailTestSupport
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

final class EmotionDetailViewTests: XCTestCase {
    
    private var useCase: EmotionDetailUseCaseInterface!
    private var repository: EmotionRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = EmotionDetailUseCase(emotionRepository: repository)
    }
    
    func test_데이터_없을_때_화면() {
        // given
        let reactor = EmotionDetailReactor(emotionID: .init(), useCase: useCase)
        let sut = EmotionDetailViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_good_감정_타입_화면() {
        // given
        let reactor = 
        EmotionDetailReactor(emotionID: .init(), useCase: useCase)
        let sut = EmotionDetailViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            viewModel: EmotionDetailViewModel(date: "2024년 03월 14일 수요일", note: "감정 상세 테스트1", emotionType: .good),
            isLoading: false
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_soso_감정_타입_화면() {
        // given
        let reactor =
        EmotionDetailReactor(emotionID: .init(), useCase: useCase)
        let sut = EmotionDetailViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            viewModel: EmotionDetailViewModel(date: "2024년 03월 14일 수요일", note: "감정 상세 테스트2", emotionType: .soso),
            isLoading: false
        )
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_bad_감정_타입_화면() {
        // given
        let reactor =
        EmotionDetailReactor(emotionID: .init(), useCase: useCase)
        let sut = EmotionDetailViewController()
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            viewModel: EmotionDetailViewModel(date: "2024년 03월 14일 수요일", note: "감정 상세 테스트3", emotionType: .bad),
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
        let reactor =
        EmotionDetailReactor(emotionID: .init(), useCase: useCase)
        let sut = EmotionDetailViewController()
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

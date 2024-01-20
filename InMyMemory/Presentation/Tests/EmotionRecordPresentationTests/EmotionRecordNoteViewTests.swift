//
//  EmotionRecordNoteViewTests.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

@testable import EmotionRecordPresentation
import PresentationTestSupport
import EmotionRecordTestSupport
import DomainTestSupport
import SnapshotTesting
import Entities
import Interfaces
import UseCases
import CoreKit
import BasePresentation
import XCTest
import Quick
import Nimble
import ReactorKit
import RxSwift

final class EmotionRecordNoteViewTests: XCTestCase {
    
    private var useCase: EmotionRecordUseCaseInterface!
    private var repository: EmotionRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = EmotionRecordUseCase(emotionRepository: repository)
    }
    
    func test_good_감정_화면() {
        // given
        let reactor = EmotionRecordNoteReactor(
            emotionType: .good,
            date: Date(),
            useCase: useCase
        )
        let sut = EmotionRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_soso_감정_화면() {
        // given
        let reactor = EmotionRecordNoteReactor(
            emotionType: .soso,
            date: Date(),
            useCase: useCase
        )
        let sut = EmotionRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_bad_감정_화면() {
        // given
        let reactor = EmotionRecordNoteReactor(
            emotionType: .bad,
            date: Date(),
            useCase: useCase
        )
        let sut = EmotionRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_bad_감정_Text_있을_때_화면() {
        // given
        let emotionType: EmotionType = .bad
        let reactor = EmotionRecordNoteReactor(
            emotionType: emotionType,
            date: Date(),
            useCase: useCase
        )
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isEnabled: true,
            isLoading: false,
            note: "Bad Emotion Test",
            emotionType: emotionType
        )
        let sut = EmotionRecordNoteViewController()
        sut.reactor = reactor
        
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_로딩_화면() {
        // given
        let emotionType: EmotionType = .bad
        let reactor = EmotionRecordNoteReactor(
            emotionType: emotionType,
            date: Date(),
            useCase: useCase
        )
        reactor.isStubEnabled = true
        reactor.stub.state.value = .init(
            isEnabled: false,
            isLoading: true,
            emotionType: emotionType
        )
        let sut = EmotionRecordNoteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

//
//  EmotionRecordViewTests.swift
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

final class EmotionRecordViewTests: XCTestCase {
    
    private var useCase: EmotionRecordUseCaseInterface!
    private var repository: EmotionRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = EmotionRecordUseCase(emotionRepository: repository)
    }
    
    func test_감정기록_화면() {
        // given
        let reactor = EmotionRecordReactor(useCase: useCase, date: Date())
        let sut = EmotionRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

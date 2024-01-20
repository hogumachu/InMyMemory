//
//  EmotionRecordCompleteViewTests.swift
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

final class EmotionRecordCompleteViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_감정기록완료_화면() {
        // given
        let reactor = EmotionRecordCompleteReactor()
        let sut = EmotionRecordCompleteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

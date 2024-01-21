//
//  RecordViewTests.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

@testable import RecordPresentation
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

final class RecordViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_기록_화면() {
        // given
        let reactor = RecordReactor(date: .init())
        let sut = RecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

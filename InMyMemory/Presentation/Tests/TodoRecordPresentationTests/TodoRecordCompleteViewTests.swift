//
//  TodoRecordCompleteViewTests.swift
//  
//
//  Created by 홍성준 on 1/21/24.
//

@testable import TodoRecordPresentation
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

final class TodoRecordCompleteViewTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    func test_viewDidLoad_되었을_때_화면() {
        // given
        let reactor = TodoRecordCompleteReactor()
        let sut = TodoRecordCompleteViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

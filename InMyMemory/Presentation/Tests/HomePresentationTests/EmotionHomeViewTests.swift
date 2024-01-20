//
//  EmotionHomeViewTests.swift
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

final class EmotionHomeViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_데이터_없을_때_화면() {
        // given
        let sut = EmotionHomeViewController()
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_감정_데이터_있을_때_화면() {
        // given
        let sut = EmotionHomeViewController()
        let viewModel: EmotionHomeViewModel = .init(
            pastWeekViewModel: .init(items: [
                .init(score: 1000, emotion: "좋아요"),
                .init(score: -20, emotion: "그냥 그래요"),
                .init(score: 300, emotion: "나빠요"),
            ]),
            graphViewModel: .init(items: [
                .init(rate: 0.9, date: "1일"),
                .init(rate: -0.9, date: "2일"),
                .init(rate: 0.9, date: "3일"),
                .init(rate: -0.7, date: "4일"),
                .init(rate: -0.4, date: "5일"),
                .init(rate: 0.1, date: "6일"),
                .init(rate: 0.6, date: "7일"),
            ])
        )
        
        // when
        sut.viewDidLoad()
        sut.viewModelBinder.onNext(viewModel)
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    private func makeDate(year: Int, month: Int, day: Int) -> Date? {
        return Calendar.current.date(from: .init(
            year: year,
            month: month,
            day: day
        ))
    }
    
}

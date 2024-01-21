//
//  DateFactoryTests.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

@testable import PresentationTestSupport
import XCTest
import Quick
import Nimble
import CoreKit

final class DateFactoryTests: QuickSpec {
    
    override class func spec() {
        var sut: DateFactory!
        
        describe("DateFactory 테스트") {
            beforeEach {
                sut = .init()
            }
            
            context("2023년 12월 25일 날짜가 주어지면") {
                var year: Int!
                var month: Int!
                var day: Int!
                var date: Date?
                
                beforeEach {
                    year = 2023
                    month = 12
                    day = 25
                    date = sut.makeDate(
                        year: year,
                        month: month,
                        day: day
                    )
                }
                
                it("생성된 날짜는 2023년 12월 25일이 된다") {
                    let date = try unwrap(date)
                    expect(date.year) == year
                    expect(date.month) == month
                    expect(date.day) == day
                }
            }
            
            context("2027년 1월 3일 날짜가 주어지면") {
                var year: Int!
                var month: Int!
                var day: Int!
                var date: Date?
                
                beforeEach {
                    year = 2027
                    month = 1
                    day = 3
                    date = sut.makeDate(
                        year: year,
                        month: month,
                        day: day
                    )
                }
                
                it("생성된 날짜는 2027년 1월 3일이 된다") {
                    let date = try unwrap(date)
                    expect(date.year) == year
                    expect(date.month) == month
                    expect(date.day) == day
                }
            }
        }
    }
    
}

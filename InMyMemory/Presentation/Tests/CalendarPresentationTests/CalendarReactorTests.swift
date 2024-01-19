//
//  CalendarReactorTests.swift
//
//
//  Created by 홍성준 on 1/17/24.
//

@testable import CalendarPresentation
import CalendarTestSupport
import PresentationTestSupport
import Entities
import Interfaces
import CoreKit
import BasePresentation
import XCTest
import Quick
import Nimble
import ReactorKit
import RxSwift

final class CalendarReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: CalendarHomeReactor!
        var useCase: CalendarUseCaseMock!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        var date: Date!
        
        describe("CalendarReactor 테스트") {
            beforeEach {
                useCase = .init()
                date = Date()
                stepBinder = .init()
                disposeBag = .init()
                sut = .init(useCase: useCase, date: date)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("초기화 되면") {
                it("날짜에 맞는 년/월 타이틀이 생성이 된다.") {
                    expect { sut.currentState.monthTitle } == "\(date.year)년 \(date.month)월"
                }
                
                it("해당 날짜의 Day가 선택이 된다.") {
                    expect { sut.currentState.selectDay } == date.day
                }
            }
            
            context("refresh가 되면") {
                let selectDay = 10
                let emotionNote = "emotionNote"
                let memoryNote = "memoryNote"
                let todoNote = "todoNote"
                var mockDays: [Day]!
                
                beforeEach {
                    let selectDate = date.replace(day: selectDay)
                    mockDays = [.init(
                        metadata: .init(
                            date: selectDate,
                            number: selectDay,
                            isValid: true
                        ),
                        items: [
                            .emotion(.init(note: emotionNote, emotionType: .bad, date: selectDate)),
                            .memory(.init(images: [], note: memoryNote, date: selectDate)),
                            .todo(.init(id: UUID(), note: todoNote, isCompleted: false, date: selectDate))
                        ])
                    ]
                    useCase.fetchDaysInMonthYearMonthDays = mockDays
                    sut.action.onNext(.refresh)
                }
                
                it("UseCase를 통해 Day 정보를 가져온다.") {
                    expect { sut.currentState.days.map { $0.metadata.date } } == mockDays.map { $0.metadata.date }
                }
                
                context("날짜가 선택이 되면") {
                    beforeEach {
                        sut.action.onNext(.dayDidTap(selectDay))
                    }
                    
                    it("해당 날짜에 대한 감정, 기억, 할일 정보를 가져온다.") {
                        let notes = sut.currentState.calendarListSections.flatMap(\.items)
                            .map { item in
                                switch item {
                                case .emotion(let model): return model.note
                                case .memory(let model): return model.note
                                case .todo(let model): return model.note
                                }
                            }
                        expect { notes.contains(emotionNote) } == true
                        expect { notes.contains(memoryNote) } == true
                        expect { notes.contains(todoNote) } == true
                    }
                }
            }
            
            context("이전 달이 선택이 되면") {
                var nextDate: Date!
                
                beforeEach {
                    nextDate = sut.initialState.date.monthsAgo(value: 1)
                    sut.action.onNext(.monthLeftDidTap)
                }
                
                it("선택된 날짜를 없앤다.") {
                    expect { sut.currentState.selectDay } == nil
                }
                
                it("날짜에 맞는 년/월 타이틀이 생성이 된다.") {
                    expect { sut.currentState.monthTitle } == "\(nextDate.year)년 \(nextDate.month)월"
                }
                
                it("UseCase를 통해 Day 정보를 가져온다.") {
                    expect { useCase.fetchDaysInMonthYearMonthYear } == nextDate.year
                    expect { useCase.fetchDaysInMonthYearMonthMonth } == nextDate.month
                }
            }
            
            context("다음 달이 선택이 되면") {
                var nextDate: Date!
                
                beforeEach {
                    nextDate = sut.initialState.date.monthsAgo(value: -1)
                    sut.action.onNext(.monthRightDidTap)
                }
                
                it("선택된 날짜를 없앤다.") {
                    expect { sut.currentState.selectDay } == nil
                }
                
                it("날짜에 맞는 년/월 타이틀이 생성이 된다.") {
                    expect { sut.currentState.monthTitle } == "\(nextDate.year)년 \(nextDate.month)월"
                }
                
                it("UseCase를 통해 Day 정보를 가져온다.") {
                    expect { useCase.fetchDaysInMonthYearMonthYear } == nextDate.year
                    expect { useCase.fetchDaysInMonthYearMonthMonth } == nextDate.month
                }
            }
            
            context("추가 버튼을 누르면") {
                beforeEach {
                    stepBinder.steps = []
                    sut.action.onNext(.addDidTap)
                }
                
                it("recordIsRequired 로 라우팅 된다") {
                    let step = try unwrap(stepBinder.steps.last as? AppStep)
                    expect {
                        guard case .recordIsRequired(let targetDate) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return (
                            targetDate.year == date.year &&
                            targetDate.month == date.month &&
                            targetDate.day == date.day
                        ) ? .succeeded : .failed(reason: "올바르지 않은 Date")
                    }.to(succeed())
                }
            }
        }
    }
    
}

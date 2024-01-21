//
//  MemoryRecordViewTests.swift
//
//
//  Created by 홍성준 on 1/20/24.
//

@testable import MemoryRecordPresentation
import MemoryRecordTestSupport
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

final class MemoryRecordViewTests: XCTestCase {
    
    private var useCase: MemoryRecordUseCaseInterface!
    private var repository: MemoryRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = .init()
        useCase = MemoryRecordUseCase(memoryRepository: repository)
    }
    
    func test_isPresent가_true일_때_화면() {
        // given
        let reactor = MemoryRecordReactor(
            isPresent: true,
            date: .init()
        )
        let sut = MemoryRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이미지가_없을_때_화면() {
        // given
        let reactor = MemoryRecordReactor(
            isPresent: false,
            memory: nil,
            imageSize: 5,
            date: .init()
        )
        let sut = MemoryRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이미지가_한개_있을_때_화면() {
        // given
        let reactor = MemoryRecordReactor(
            isPresent: false,
            memory: .init(images: [
                UIImage.checkmark.pngData()!
            ], note: "Test Note", date: .init()),
            imageSize: 5,
            date: .init()
        )
        let sut = MemoryRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이미지가_두개_있을_때_화면() {
        // given
        let reactor = MemoryRecordReactor(
            isPresent: false,
            memory: .init(images: [
                UIImage.checkmark.pngData()!,
                UIImage.checkmark.pngData()!,
            ], note: "Test Note", date: .init()),
            imageSize: 5,
            date: .init()
        )
        let sut = MemoryRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
    func test_이미지가_다섯개_있을_때_화면() {
        // given
        let reactor = MemoryRecordReactor(
            isPresent: false,
            memory: .init(images: [
                UIImage.checkmark.pngData()!,
                UIImage.checkmark.pngData()!,
                UIImage.checkmark.pngData()!,
                UIImage.checkmark.pngData()!,
                UIImage.checkmark.pngData()!,
            ], note: "Test Note", date: .init()),
            imageSize: 5,
            date: .init()
        )
        let sut = MemoryRecordViewController()
        sut.reactor = reactor
        
        // when
        sut.viewDidLoad()
        
        // then
        assertSnapshots(of: sut, as: [.image(on: .iPhone13)])
    }
    
}

// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BasePresentation",
            targets: ["BasePresentation"]
        ),
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]
        ),
        .library(
            name: "HomeInterface",
            targets: ["HomeInterface"]
        ),
        .library(
            name: "HomePresentation",
            targets: ["HomePresentation"]
        ),
        .library(
            name: "HomeTestSupport",
            targets: ["HomeTestSupport"]
        ),
        .library(
            name: "RecordInterface",
            targets: ["RecordInterface"]
        ),
        .library(
            name: "RecordPresentation",
            targets: ["RecordPresentation"]
        ),
        .library(
            name: "EmotionDetailInterface",
            targets: ["EmotionDetailInterface"]
        ),
        .library(
            name: "EmotionDetailPresentation",
            targets: ["EmotionDetailPresentation"]
        ),
        .library(
            name: "EmotionDetailTestSupport",
            targets: ["EmotionDetailTestSupport"]
        ),
        .library(
            name: "EmotionRecordInterface",
            targets: ["EmotionRecordInterface"]
        ),
        .library(
            name: "EmotionRecordPresentation",
            targets: ["EmotionRecordPresentation"]
        ),
        .library(
            name: "EmotionRecordTestSupport",
            targets: ["EmotionRecordTestSupport"]
        ),
        .library(
            name: "MemoryDetailInterface",
            targets: ["MemoryDetailInterface"]
        ),
        .library(
            name: "MemoryDetailPresentation",
            targets: ["MemoryDetailPresentation"]
        ),
        .library(
            name: "MemoryDetailTestSupport",
            targets: ["MemoryDetailTestSupport"]
        ),
        .library(
            name: "MemoryRecordInterface",
            targets: ["MemoryRecordInterface"]
        ),
        .library(
            name: "MemoryRecordPresentation",
            targets: ["MemoryRecordPresentation"]
        ),
        .library(
            name: "MemoryRecordTestSupport",
            targets: ["MemoryRecordTestSupport"]
        ),
        .library(
            name: "PresentationTestSupport",
            targets: ["PresentationTestSupport"]
        ),
        .library(
            name: "CalendarInterface",
            targets: ["CalendarInterface"]
        ),
        .library(
            name: "CalendarPresentation",
            targets: ["CalendarPresentation"]
        ),
        .library(
            name: "CalendarTestSupport",
            targets: ["CalendarTestSupport"]
        ),
        .library(
            name: "SearchInterface",
            targets: ["SearchInterface"]
        ),
        .library(
            name: "SearchPresentation",
            targets: ["SearchPresentation"]
        ),
        .library(
            name: "TodoRecordInterface",
            targets: ["TodoRecordInterface"]
        ),
        .library(
            name: "TodoRecordPresentation",
            targets: ["TodoRecordPresentation"]
        ),
    ],
    dependencies: [
        .package(path: "../Shared"),
        .package(path: "../Domain"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", .upToNextMajor(from: "2.13.0")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.2")),
        .package(url: "https://github.com/Quick/Quick.git", from: "7.3.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "13.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    ],
    targets: [
        .target(
            name: "BasePresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                "DesignKit",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                .product(name: "Entities", package: "Domain"),
            ]
        ),
        .target(
            name: "DesignKit",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
                "Then"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "HomeInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "HomePresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "RecordInterface",
                "EmotionRecordInterface",
                "MemoryRecordInterface",
                "CalendarInterface",
                "MemoryDetailInterface",
                "DesignKit",
                "HomeInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "HomeTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "HomeInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "RecordInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "RecordPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "EmotionRecordInterface",
                "MemoryRecordInterface",
                "TodoRecordInterface",
                "DesignKit",
                "RecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionDetailInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionDetailPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "EmotionDetailInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionDetailTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "EmotionDetailInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionRecordInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionRecordPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "EmotionRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "EmotionRecordTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "EmotionRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryDetailInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryDetailPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "MemoryDetailInterface",
                "MemoryRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryDetailTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "MemoryDetailInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryRecordInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryRecordPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "MemoryRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "MemoryRecordTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "MemoryRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "PresentationTestSupport",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "CalendarInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "CalendarPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "CalendarInterface",
                "SearchInterface",
                "RecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "CalendarTestSupport",
            dependencies: [
                "RxSwift",
                "BasePresentation",
                "CalendarInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "SearchInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "SearchPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                "RxDataSources",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "SearchInterface",
                "EmotionDetailInterface",
                "MemoryDetailInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "TodoRecordInterface",
            dependencies: [
                "RxSwift",
                "RxFlow",
                "BasePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .target(
            name: "TodoRecordPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                "RxDataSources",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                "TodoRecordInterface",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
        .testTarget(
            name: "HomePresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "HomeTestSupport",
                "HomePresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "CalendarPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "CalendarTestSupport",
                "CalendarPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "EmotionRecordPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "EmotionRecordTestSupport",
                "EmotionRecordPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "MemoryRecordPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "MemoryRecordTestSupport",
                "MemoryRecordPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "MemoryDetailPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "MemoryDetailTestSupport",
                "MemoryDetailPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "RecordPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "RecordPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "SearchPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "SearchPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "TodoRecordPresentationTests",
            dependencies: [
                "PresentationTestSupport",
                "TodoRecordPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
                "Quick",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "PresentationTestSupportTests",
            dependencies: [
                "PresentationTestSupport",
                "Quick",
                "Nimble",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
                .product(name: "DomainTestSupport", package: "Domain"),
            ]
        ),
    ]
)

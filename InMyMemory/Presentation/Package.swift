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
            name: "RecordInterface",
            targets: ["RecordInterface"]
        ),
        .library(
            name: "RecordPresentation",
            targets: ["RecordPresentation"]
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
            name: "MemoryRecordInterface",
            targets: ["MemoryRecordInterface"]
        ),
        .library(
            name: "MemoryRecordPresentation",
            targets: ["MemoryRecordPresentation"]
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
            name: "CalendarPresentationTests",
            dependencies: [
                "CalendarTestSupport",
                "CalendarPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                "Quick",
                "Nimble"
            ]
        ),
        .testTarget(
            name: "EmotionRecordPresentationTests",
            dependencies: [
                "EmotionRecordTestSupport",
                "EmotionRecordPresentation",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
                "Quick",
                "Nimble"
            ]
        ),
    ]
)

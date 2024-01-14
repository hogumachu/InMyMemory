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
            name: "HomePresentation",
            targets: ["HomePresentation"]
        ),
        .library(
            name: "RecordPresentation",
            targets: ["RecordPresentation"]
        ),
        .library(
            name: "EmotionRecordPresentation",
            targets: ["EmotionRecordPresentation"]
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
            name: "CalendarPresentation",
            targets: ["CalendarPresentation"]
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
    ],
    targets: [
        .target(
            name: "BasePresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
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
            name: "HomePresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "RecordPresentation",
                "EmotionRecordPresentation",
                "CalendarPresentation",
                "MemoryDetailInterface",
                "DesignKit",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
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
                "EmotionRecordPresentation",
                "MemoryRecordInterface",
                "DesignKit",
                .product(name: "CoreKit", package: "Shared"),
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
            name: "CalendarPresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
                "RxFlow",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Then",
                "BasePresentation",
                "DesignKit",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        ),
    ]
)

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
    ],
    dependencies: [
        .package(path: "../Shared"),
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
                "Then"
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
                "DesignKit",
                .product(name: "CoreKit", package: "Shared"),
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
                "DesignKit",
                .product(name: "CoreKit", package: "Shared"),
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
            ]
        ),
    ]
)

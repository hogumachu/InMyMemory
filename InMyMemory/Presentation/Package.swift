// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    products: [
        .library(
            name: "BasePresentation",
            targets: ["BasePresentation"]
        ),
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .target(
            name: "BasePresentation",
            dependencies: [
                "RxSwift",
                "ReactorKit",
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
    ]
)

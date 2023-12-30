// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BasePresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BasePresentation",
            targets: ["BasePresentation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0")),
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
    ]
)

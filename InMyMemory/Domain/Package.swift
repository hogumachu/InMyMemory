// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Entities",
            targets: ["Entities"]
        ),
        .library(
            name: "Interfaces",
            targets: ["Interfaces"]
        ),
        .library(
            name: "UseCases",
            targets: ["UseCases"]
        ),
        .library(
            name: "DomainTestSupport",
            targets: ["DomainTestSupport"]
        ),
    ],
    dependencies: [
        .package(path: "../Shared"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.4")),
        .package(url: "https://github.com/Quick/Quick.git", from: "7.3.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "13.1.2"),
    ],
    targets: [
        .target(
            name: "Entities",
            dependencies: []
        ),
        .target(
            name: "Interfaces",
            dependencies: [
                "RxSwift",
                "Entities",
            ]
        ),
        .target(
            name: "UseCases",
            dependencies: [
                "RxSwift",
                "Entities",
                "Interfaces",
                .product(name: "CoreKit", package: "Shared"),
            ]
        ),
        .target(
            name: "DomainTestSupport",
            dependencies: [
                "RxSwift",
                "Swinject",
                "Entities",
                "Interfaces",
                .product(name: "CoreKit", package: "Shared"),
            ]
        ),
        .testTarget(
            name: "UseCaseTests",
            dependencies: [
                "UseCases",
                "Entities",
                "Interfaces",
                "DomainTestSupport",
                "RxSwift",
                .product(name: "CoreKit", package: "Shared"),
                "Quick",
                "Nimble"
            ]
        ),
    ]
)

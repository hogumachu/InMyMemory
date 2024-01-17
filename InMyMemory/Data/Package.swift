// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "PersistentStorages",
            targets: ["PersistentStorages"]
        ),
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
    ],
    dependencies: [
        .package(path: "../Shared"),
        .package(path: "../Domain"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.4")),
    ],
    targets: [
        .target(
            name: "PersistentStorages",
            dependencies: [
                "RxSwift",
                .product(name: "Entities", package: "Domain"),
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: [
                "RxSwift",
                "Swinject",
                "PersistentStorages",
                .product(name: "CoreKit", package: "Shared"),
                .product(name: "Entities", package: "Domain"),
                .product(name: "Interfaces", package: "Domain"),
            ]
        )
    ]
)

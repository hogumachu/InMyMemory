// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.4")),
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                "Swinject"
            ]
        ),
    ]
)

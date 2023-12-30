// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignKit",
    products: [
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DesignKit"
        ),
        .testTarget(
            name: "DesignKitTests",
            dependencies: ["DesignKit"]),
    ]
)

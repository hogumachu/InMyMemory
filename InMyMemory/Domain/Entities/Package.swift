// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Entities",
    products: [
        .library(
            name: "Entities",
            targets: ["Entities"]),
    ],
    targets: [
        .target(
            name: "Entities"),
        .testTarget(
            name: "EntitiesTests",
            dependencies: ["Entities"]),
    ]
)

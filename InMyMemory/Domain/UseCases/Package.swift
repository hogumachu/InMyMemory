// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UseCases",
    products: [
        .library(
            name: "UseCases",
            targets: ["UseCases"]),
    ],
    targets: [
        .target(
            name: "UseCases"),
        .testTarget(
            name: "UseCasesTests",
            dependencies: ["UseCases"]),
    ]
)

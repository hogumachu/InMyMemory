// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
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
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Entities",
            dependencies: []
        ),
        .target(
            name: "Interfaces",
            dependencies: []
        ),
        .target(
            name: "UseCases",
            dependencies: []
        ),
    ]
)

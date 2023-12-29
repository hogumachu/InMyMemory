// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]),
    ],
    targets: [
        .target(
            name: "Repositories"),
        .testTarget(
            name: "RepositoriesTests",
            dependencies: ["Repositories"]),
    ]
)

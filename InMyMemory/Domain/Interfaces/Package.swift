// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Interfaces",
    products: [
        .library(
            name: "Interfaces",
            targets: ["Interfaces"]),
    ],
    targets: [
        .target(
            name: "Interfaces"),
        .testTarget(
            name: "InterfacesTests",
            dependencies: ["Interfaces"]),
    ]
)

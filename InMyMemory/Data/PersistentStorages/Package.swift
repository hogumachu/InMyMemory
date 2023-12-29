// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistentStorages",
    products: [
        .library(
            name: "PersistentStorages",
            targets: ["PersistentStorages"]),
    ],
    targets: [
        .target(
            name: "PersistentStorages"),
        .testTarget(
            name: "PersistentStoragesTests",
            dependencies: ["PersistentStorages"]),
    ]
)

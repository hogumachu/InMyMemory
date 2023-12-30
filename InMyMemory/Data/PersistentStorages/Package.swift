// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistentStorages",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SwiftDataStorage",
            targets: ["SwiftDataStorage"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftDataStorage",
            dependencies: []
        )
    ]
)

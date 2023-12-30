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
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
    ],
    targets: [
        .target(
            name: "PersistentStorages",
            dependencies: [
                "RxSwift"
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: []
        )
    ]
)

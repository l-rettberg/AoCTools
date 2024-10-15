// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "AoCTools",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "AoCTools", targets: ["AoCTools"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.1"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "AoCTools",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AoCToolsTests",
            dependencies: ["AoCTools"],
            path: "Tests"
            ]
        )
    ]
)

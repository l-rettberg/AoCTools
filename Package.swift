// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AoCTools",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "AoCTools", targets: ["AoCTools"])
    ],
    targets: [
        .target(name: "AoCTools", path: "Sources"),
        .testTarget(name: "AoCToolsTests", dependencies: ["AoCTools"], path: "Tests")
    ]
)

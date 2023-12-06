// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AoCTools",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "AoCTools", targets: ["AoCTools"])
    ],
    dependencies: [
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.2.2")
    ],
    targets: [
        .target(
            name: "AoCTools",
            path: "Sources",
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        ),
        .testTarget(
            name: "AoCToolsTests",
            dependencies: ["AoCTools"],
            path: "Tests",
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        )
    ]
)

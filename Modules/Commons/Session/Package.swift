// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Session",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "Session",
            targets: ["Session"])
    ],
    targets: [
        .target(
            name: "Session"),
        .testTarget(
            name: "SessionTests",
            dependencies: ["Session"]
        ),
    ]
)

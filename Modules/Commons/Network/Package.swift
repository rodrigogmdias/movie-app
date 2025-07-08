// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Network",
            targets: ["Network"])
    ],
    dependencies: [
        .package(path: "../Session")
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .product(name: "Session", package: "Session")
            ]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]
        ),
    ]
)

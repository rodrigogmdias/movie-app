// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "MovieDetail",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "MovieDetail",
            targets: ["MovieDetail"])
    ],
    dependencies: [
        .package(name: "Network", path: "../Network"),
        .package(name: "Components", path: "../Components"),
    ],
    targets: [
        .target(
            name: "MovieDetail",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Components", package: "Components"),
            ]
        ),
        .testTarget(
            name: "MovieDetailTests",
            dependencies: ["MovieDetail"]
        ),
    ]
)

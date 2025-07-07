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
        .package(name: "Network", path: "../../Commons/Network"),
        .package(name: "Components", path: "../../Commons/Components"),
        .package(name: "SharedPreferences", path: "../../Commons/SharedPreferences"),
    ],
    targets: [
        .target(
            name: "MovieDetail",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Components", package: "Components"),
                .product(name: "SharedPreferences", package: "SharedPreferences"),
            ]
        ),
        .testTarget(
            name: "MovieDetailTests",
            dependencies: ["MovieDetail"]
        ),
    ]
)

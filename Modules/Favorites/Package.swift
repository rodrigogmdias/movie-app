// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "Favorites",
            targets: ["Favorites"])
    ],
    targets: [
        .target(
            name: "Favorites"),
        .testTarget(
            name: "FavoritesTests",
            dependencies: ["Favorites"]
        ),
    ]
)

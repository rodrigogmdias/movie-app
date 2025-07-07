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
    dependencies: [
        .package(name: "SharedPreferences", path: "../../Commons/SharedPreferences"),
    ],
    targets: [
        .target(
            name: "Favorites",
            dependencies: [
                .product(name: "SharedPreferences", package: "SharedPreferences")
            ],
        ),
        .testTarget(
            name: "FavoritesTests",
            dependencies: ["Favorites"]
        ),
    ]
)

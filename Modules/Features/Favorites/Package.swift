// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Favorites",
            targets: ["Favorites"])
    ],
    dependencies: [
        .package(name: "SharedPreferences", path: "../../Commons/SharedPreferences"),
        .package(name: "MovieDetail", path: "../MovieDetail"),
    ],
    targets: [
        .target(
            name: "Favorites",
            dependencies: [
                .product(name: "SharedPreferences", package: "SharedPreferences"),
                .product(name: "MovieDetail", package: "MovieDetail"),
            ],
        ),
        .testTarget(
            name: "FavoritesTests",
            dependencies: ["Favorites"]
        ),
    ]
)

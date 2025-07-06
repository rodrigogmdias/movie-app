// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "BottomNavigator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "BottomNavigator",
            targets: ["BottomNavigator"])
    ],
    dependencies: [
        .package(name: "Catalog", path: "../Catalog"),
        .package(name: "Favorites", path: "../Favorites"),
    ],
    targets: [
        .target(
            name: "BottomNavigator",
            dependencies: [
                .product(name: "Catalog", package: "Catalog"),
                .product(name: "Favorites", package: "Favorites"),
            ]
        ),
        .testTarget(
            name: "BottomNavigatorTests",
            dependencies: ["BottomNavigator"]
        ),
    ]
)

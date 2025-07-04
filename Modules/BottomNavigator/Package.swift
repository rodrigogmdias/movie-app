// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BottomNavigator",
    platforms: [
        // Platforms define the platforms that this package supports.
        .iOS(.v16),  // Minimum iOS version supported
        .macOS(.v13),  // Minimum macOS version supported
        .watchOS(.v9),  // Minimum watchOS version supported
        .tvOS(.v16),  // Minimum tvOS version supported
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BottomNavigator",
            targets: ["BottomNavigator"])
    ],
    dependencies: [
        .package(name: "Catalog", path: "../Catalog"),
        .package(name: "Favorites", path: "../Favorites"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
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

// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [
        // Platforms define the minimum OS versions that the package supports.
        .iOS(.v16),  // Minimum iOS version
        .macOS(.v13),  // Minimum macOS version
        .tvOS(.v16),  // Minimum tvOS version
        .watchOS(.v9),  // Minimum watchOS version
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Favorites",
            targets: ["Favorites"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Favorites"),
        .testTarget(
            name: "FavoritesTests",
            dependencies: ["Favorites"]
        ),
    ]
)

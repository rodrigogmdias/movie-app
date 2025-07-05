// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Catalog",
    platforms: [
        // Platforms define the minimum OS versions supported by this package.
        .iOS(.v16),  // Minimum iOS version supported
        .macOS(.v13),  // Minimum macOS version supported
        .watchOS(.v9),  // Minimum watchOS version supported
        .tvOS(.v16),  // Minimum tvOS version supported
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Catalog",
            targets: ["Catalog"])
    ],
    dependencies: [
        .package(name: "Network", path: "../Network"),
        .package(name: "Components", path: "../Components"),
        .package(name: "MovieDetail", path: "../MovieDetail"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Catalog",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Components", package: "Components"),
                .product(name: "MovieDetail", package: "MovieDetail"),
            ]
        ),
        .testTarget(
            name: "CatalogTests",
            dependencies: ["Catalog"]
        ),
    ]
)

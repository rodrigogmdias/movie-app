// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Catalog",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Catalog",
            targets: ["Catalog"])
    ],
    dependencies: [
        .package(name: "Network", path: "../../Commons/Network"),
        .package(name: "Components", path: "../../Commons/Components"),
        .package(name: "MovieDetail", path: "../MovieDetail"),
    ],
    targets: [
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

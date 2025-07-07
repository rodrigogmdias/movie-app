// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Components",
            targets: ["Components"])
    ],
    dependencies: [
        .package(url: "https://github.com/0xWDG/CachedAsyncImage.git", branch: "main")
    ],
    targets: [
        .target(
            name: "Components",
            dependencies: [
                .product(name: "CachedAsyncImage", package: "cachedasyncimage")
            ]
        ),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]
        ),
    ]
)

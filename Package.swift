// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "DivaUI",
    products: [
        .library(
            name: "DivaUI",
            targets: ["DivaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CarsonAurum/DivaLibrary.git", branch: "master")
    ],
    targets: [
        .target(
            name: "DivaUI",
            dependencies: []),
        .testTarget(
            name: "DivaUITests",
            dependencies: ["DivaUI"]),
    ]
)

// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "DivaUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "DivaUI",
            targets: ["DivaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CarsonAurum/DivaLibrary.git", branch: "master")
    ],
    targets: [
        .target(name: "DivaUI", dependencies: ["DivaGrid", "DivaLibrary"]),
        .target(name: "DivaGrid", dependencies: ["DivaLibrary"])
    ]
)

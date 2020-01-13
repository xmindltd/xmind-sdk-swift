// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XMindSDK",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
    ],
    products: [
        .library(
            name: "XMindSDK",
            targets: ["XMindSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.3"))
    ],
    targets: [
        .target(
            name: "XMindSDK",
            dependencies:[
                "ZIPFoundation",
                "CryptoSwift"
            ],
            path: "Sources"),
    ]
)


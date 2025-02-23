// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "skip-fuse",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipFuse", type: .dynamic, targets: ["SkipFuse"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip-android-bridge.git", "0.0.0"..<"2.0.0"),
    ],
    targets: [
        .target(name: "SkipFuse", dependencies: [
            .product(name: "SkipAndroidBridge", package: "skip-android-bridge"),
        ]),
        .testTarget(name: "SkipFuseTests", dependencies: ["SkipFuse"]),
    ]
)

// swift-tools-version: 6.0
// Copyright 2026 Skip
// SPDX-License-Identifier: MPL-2.0
import PackageDescription

// Two dynamic products sharing automatic-library dependencies reproduce the
// Fuse graph used by checkup without requiring SwiftUI on the Linux host.
let package = Package(
    name: "FuseAPKSmoke",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "FuseSmoke", type: .dynamic, targets: ["FuseSmoke"]),
        .library(name: "FuseModel", type: .dynamic, targets: ["FuseModel"]),
    ],
    // The shared library products in this graph honour SKIP_DYNAMIC_LIBRARIES as of
    // skip-lib 1.4.2, skip-unit 1.7.2, skip-model 1.7.10 and skip-foundation 1.4.5,
    // which is what lets the swiftbuild build system accept it: without dynamic
    // products, two dynamic products (SkipBridge and SkipAndroidBridge) each
    // statically link the same automatic-library products and swiftbuild rejects
    // the duplication. Those come in transitively through skip-fuse, so only the
    // direct dependencies are listed here.
    dependencies: [
        .package(path: "../../.."),
        .package(url: "https://github.com/skiptools/skip-model.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "FuseSmoke", dependencies: [
            "FuseModel",
            .product(name: "SkipFuse", package: "skip-fuse"),
            .product(name: "SkipModel", package: "skip-model"),
        ]),
        .target(name: "FuseModel", dependencies: [
            .product(name: "SkipFuse", package: "skip-fuse"),
            .product(name: "SkipModel", package: "skip-model"),
        ]),
        .testTarget(name: "FuseSmokeTests", dependencies: ["FuseSmoke"]),
    ]
)

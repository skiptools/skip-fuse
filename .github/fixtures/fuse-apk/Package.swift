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

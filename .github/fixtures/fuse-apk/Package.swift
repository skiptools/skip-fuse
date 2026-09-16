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
    // TEMPORARY: the shared library products below are pinned to their `dynamic-libs`
    // branches, which add the SKIP_DYNAMIC_LIBRARIES check that builds them as dynamic
    // products. Without it the swiftbuild build system rejects this graph, because two
    // dynamic products (SkipBridge and SkipAndroidBridge) each statically link the same
    // automatic-library products. skip-lib, skip-unit and skip-foundation are transitive
    // dependencies of skip-fuse; they are declared here so the root branch requirement
    // overrides the version requirement that skip-fuse states for them.
    // Restore the `from:` requirements once those PRs are merged and released:
    //   skip-lib#49, skip-unit#24, skip-model#30, skip-foundation#132
    dependencies: [
        .package(path: "../../.."),
        .package(url: "https://github.com/skiptools/skip-model.git", branch: "dynamic-libs"),
        .package(url: "https://github.com/skiptools/skip-lib.git", branch: "dynamic-libs"),
        .package(url: "https://github.com/skiptools/skip-unit.git", branch: "dynamic-libs"),
        .package(url: "https://github.com/skiptools/skip-foundation.git", branch: "dynamic-libs"),
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

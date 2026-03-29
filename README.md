# SkipFuse

SkipFuse helps fuse the Swift and Android worlds for [Skip Fuse](https://skip.dev/docs/modes/#fuse) modules and apps. It is an umbrella framework that vends cross-platform functionality. For example, SkipFuse:

- Vends OSLog APIs on Android so that your OSLog messages appear in Android's Logcat logging.
- Transparently integrates your Swift `@Observables` into Jetpack Compose, so that they can transparently power Compose UI.
- Includes the `AnyDynamicObject` type for invoking Kotlin/Java API from compiled Swift with zero setup.

Skip will be enhancing SkipFuse over time to integrate many additional Swift foundational APIs with Android.

See the Skip [documentation](https://skip.dev/docs/) for details.

## Setup

To include this framework in your project, add the following
dependency to your `Package.swift` file:

```swift
let package = Package(
    name: "my-package",
    products: [
        .library(name: "MyProduct", targets: ["MyTarget"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.dev/skip-fuse.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .product(name: "SkipFuse", package: "skip-fuse")
        ])
    ]
)
```

## License

This software is licensed under the 
[Mozilla Public License 2.0](https://www.mozilla.org/MPL/).

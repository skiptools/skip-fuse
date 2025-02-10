# SkipFuse

SkipFuse helps fuse the Swift and Android worlds for [native Skip](https://skip.tools/docs/modes/#native) modules and apps. It is an umbrella framework that vends cross-platform functionality. For example, SkipFuse:

- Vends OSLog APIs on Android so that your OSLog messages appear in Android's Logcat logging.
- Magically integrates your Swift `@Observables` into Jetpack Compose, so that they can transparently power Compose UI.
- Includes the `AnyDynamicObject` type for invoking Kotlin/Java API from compiled Swift with zero setup.

Skip will be enhancing SkipFuse over time to integrate many additional Swift foundational APIs with Android.

See the Skip [documentation](https://skip.tools/docs/) for details.




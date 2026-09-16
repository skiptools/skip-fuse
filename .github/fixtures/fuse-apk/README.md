# Fuse APK compatibility fixture

The `Fuse APK compatibility` workflow exercises all eight combinations of
Swift 6.3/6.4, native/swiftbuild, and macOS Intel/Ubuntu. It uses the checked-out
SkipFuse package, released dependencies, and a matching Swift Android SDK.
Exact toolchain versions and Package.resolved are uploaded with each run.

The two dynamic products share SkipFuse and SkipModel. This recreates the
static-dependency diamonds exposed by `skip checkup --native` without adding
SwiftUI, which would prevent testing the same fixture on Linux.

Each job first builds on the host without SKIP_BRIDGE, then independently runs
`skip android test --apk` on an x86_64 API 28 emulator. The latter compiles the
Swift Testing bundle, builds and installs a test APK, and executes the test via
Android instrumentation. It is not a Gradle/Robolectric or adb-shell test.
The test calls through both fixture modules and checks the result on Android;
the script also checks the event stream to reject an empty test run.

Both phases explicitly select the matrix build system. Host failure does not
prevent collecting APK results, but either failure makes the job fail. Setup
failures remain failures, and skipped phases are reported as skipped rather
than being counted as passing. No matrix combinations are excluded or treated
as expected failures. Logs and test events are uploaded even on failure.

No linkage workaround is enabled: this is a regression fixture for the current
behavior. A future environment-based linkage fix must also be applied to the
host command here, matching Skip's normal Fuse host-build behavior.

To reproduce from the repository root (with an emulator and matching SDK
already installed):

```sh
swiftly run swift build --package-path .github/fixtures/fuse-apk --build-system swiftbuild +6.4
mkdir -p ci-results
SWIFT_VERSION=6.4 BUILD_SYSTEM=swiftbuild RUNNER_TEMP=/tmp bash .github/scripts/test-fuse-apk.sh
```

The fixture tests APK packaging and Swift execution, not a full UI application
or IPA export. The existing framework workflow continues to provide its own
coverage separately.

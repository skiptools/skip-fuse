// Copyright 2026 Skip
// SPDX-License-Identifier: MPL-2.0
import FuseSmoke
import Testing

@Test func apkSmokeTest() {
    #expect(smokeValue() == 42)
    #if !os(Android)
    Issue.record("This test must execute inside the Android test APK")
    #endif
}

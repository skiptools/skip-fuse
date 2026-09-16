#!/bin/bash
set -euo pipefail

# Retain the generated APK in a known location for the artifact upload.
export TMPDIR="$RUNNER_TEMP/fuse-apk-staging/"
mkdir -p "$TMPDIR"

skip android test --apk --verbose --no-cleanup \
    --package-path .github/fixtures/fuse-apk \
    --scratch-path "$RUNNER_TEMP/fuse-apk-android" \
    --swift-version "$SWIFT_VERSION" --arch x86_64 \
    --android-api-level 28 --android-connect-timeout 120 \
    --event-stream-output-path "$PWD/ci-results/events.jsonl" \
    --build-system "$BUILD_SYSTEM" 2>&1 | tee ci-results/apk.log

# An instrumentation command returning zero is not enough: ensure Swift Testing
# discovered and completed our test, rather than silently running zero tests.
python3 - <<'PY'
import json
from pathlib import Path

events = [json.loads(line) for line in Path("ci-results/events.jsonl").read_text().splitlines() if line.strip()]
completed = [event.get("payload", {}) for event in events if event.get("payload", {}).get("kind") == "testEnded"]
assert any("apkSmokeTest" in json.dumps(event) for event in completed), "apkSmokeTest did not complete"
assert not any(event.get("payload", {}).get("kind") == "issueRecorded" for event in events), "Swift Testing reported an issue"
PY

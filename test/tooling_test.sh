#!/bin/sh

set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
actual=$(PATH="$root/test/support/bin:$PATH" "$root/bin/hwt-ticket" 'Test ticket creation')
expected='{"branchName":"rms-123-test-ticket","metadata":{"identifier":"RMS-123","title":"Test ticket creation","url":"https://linear.app/srms/issue/RMS-123"}}'

test "$actual" = "$expected"

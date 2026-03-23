#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
PASS_COUNT=0
FAIL_COUNT=0

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT HUP INT TERM

copy_fixture_root() {
  fixture_name=$1
  target_dir=$TMP_DIR/$fixture_name
  cp -R "$ROOT_DIR/scripts/sdd/test-fixtures/$fixture_name" "$target_dir"
  printf '%s\n' "$target_dir"
}

run_validator() {
  root_path=$1
  log_file=$2

  set +e
  sh "$ROOT_DIR/scripts/sdd/validate_framework_docs.sh" --root "$root_path" > "$log_file" 2>&1
  status=$?
  set -e
  return "$status"
}

expect_pass() {
  root_path=$1
  test_name=$2
  log_file="$TMP_DIR/${test_name}.log"

  if run_validator "$root_path" "$log_file"; then
    return 0
  fi

  echo "Unexpected framework validation failure for $test_name" >&2
  cat "$log_file" >&2
  return 1
}

expect_fail_with() {
  root_path=$1
  test_name=$2
  expected_message=$3
  log_file="$TMP_DIR/${test_name}.log"

  if run_validator "$root_path" "$log_file"; then
    echo "Unexpected framework validation pass for $test_name" >&2
    cat "$log_file" >&2
    return 1
  fi

  if ! grep -Fq "$expected_message" "$log_file"; then
    echo "Missing expected framework validation message for $test_name" >&2
    echo "Expected: $expected_message" >&2
    cat "$log_file" >&2
    return 1
  fi

  return 0
}

run_test() {
  test_name=$1

  if "$test_name"; then
    PASS_COUNT=$((PASS_COUNT + 1))
    echo "PASS $test_name"
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    echo "FAIL $test_name"
  fi
}

test_passes_when_framework_navigation_and_bridge_docs_are_aligned() {
  root_path=$(copy_fixture_root "framework-valid")
  expect_pass "$root_path" "framework_valid"
}

test_fails_when_docs_readme_loses_canonical_self_audit_pointer() {
  root_path=$(copy_fixture_root "framework-valid")
  sed -i '/framework-self-audit/d' "$root_path/docs/README.md"
  expect_fail_with "$root_path" "framework_missing_self_audit_pointer" "missing canonical pointer to framework self-audit guidance"
}

test_fails_when_bridge_start_here_loses_canonical_pointer() {
  root_path=$(copy_fixture_root "framework-valid")
  sed -i '/AGENTS/d' "$root_path/agent/START_HERE.md"
  expect_fail_with "$root_path" "framework_missing_bridge_pointer" "missing pointer to ../AGENTS.md"
}

TESTS="
test_passes_when_framework_navigation_and_bridge_docs_are_aligned
test_fails_when_docs_readme_loses_canonical_self_audit_pointer
test_fails_when_bridge_start_here_loses_canonical_pointer
"

for test_name in $TESTS; do
  run_test "$test_name"
done

echo
echo "Test summary: $PASS_COUNT passed, $FAIL_COUNT failed"

[ "$FAIL_COUNT" -eq 0 ]

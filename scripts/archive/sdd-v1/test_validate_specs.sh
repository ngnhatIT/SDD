#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
FEATURE_PREFIX="__sdd-validator-suite-"
PASS_COUNT=0
FAIL_COUNT=0
CREATED_FEATURES=""
CREATED_PACKS=""

cleanup() {
  for feature_dir in $CREATED_FEATURES; do
    rm -rf "$feature_dir"
  done
  for pack_file in $CREATED_PACKS; do
    rm -f "$pack_file"
  done
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT HUP INT TERM

copy_fixture() {
  fixture_name=$1
  test_slug=$2
  target_name="${FEATURE_PREFIX}${test_slug}"
  source_dir="$ROOT_DIR/scripts/sdd/test-fixtures/$fixture_name"
  target_dir="$ROOT_DIR/docs/specs/$target_name"

  rm -rf "$target_dir"
  cp -R "$source_dir" "$target_dir"
  CREATED_FEATURES="$target_dir $CREATED_FEATURES"

  if [ -f "$target_dir/spec-pack.manifest.yaml" ]; then
    output_ref="docs/spec-packs/${target_name}.pack.md"
    sed -i "s#^output: .*#output: $output_ref#" "$target_dir/spec-pack.manifest.yaml"
    if grep -Eq '^feature_root:' "$target_dir/spec-pack.manifest.yaml"; then
      sed -i "s#^feature_root: .*#feature_root: docs/specs/$target_name#" "$target_dir/spec-pack.manifest.yaml"
    fi
    rm -f "$ROOT_DIR/$output_ref"
    CREATED_PACKS="$ROOT_DIR/$output_ref $CREATED_PACKS"
  fi

  printf '%s\n' "$target_name"
}

build_pack_if_needed() {
  feature_name=$1
  feature_ref="docs/specs/$feature_name"

  if [ -f "$ROOT_DIR/$feature_ref/spec-pack.manifest.yaml" ]; then
    sh "$ROOT_DIR/scripts/sdd/build_spec_pack.sh" "$feature_ref" > "$TMP_DIR/${feature_name}.build.log" 2>&1
  fi
}

run_validator() {
  feature_name=$1
  log_file=$2
  feature_ref="docs/specs/$feature_name"

  set +e
  sh "$ROOT_DIR/scripts/sdd/validate_specs.sh" "$feature_ref" > "$log_file" 2>&1
  status=$?
  set -e
  return "$status"
}

expect_pass() {
  feature_name=$1
  test_name=$2
  log_file="$TMP_DIR/${test_name}.log"

  if run_validator "$feature_name" "$log_file"; then
    return 0
  fi

  echo "Unexpected validation failure for $test_name" >&2
  cat "$log_file" >&2
  return 1
}

expect_fail_with() {
  feature_name=$1
  test_name=$2
  expected_message=$3
  log_file="$TMP_DIR/${test_name}.log"

  if run_validator "$feature_name" "$log_file"; then
    echo "Unexpected validation pass for $test_name" >&2
    cat "$log_file" >&2
    return 1
  fi

  if ! grep -Fq "$expected_message" "$log_file"; then
    echo "Missing expected validation message for $test_name" >&2
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

test_passes_when_reduced_path_fixture_meets_required_minimum() {
  feature_name=$(copy_fixture "valid-reduced-path" "passes-reduced-path-valid")
  expect_pass "$feature_name" "passes_reduced_path_valid"
}

test_passes_when_full_path_fixture_and_generated_pack_are_aligned() {
  feature_name=$(copy_fixture "valid-full-path" "passes-full-path-valid")
  build_pack_if_needed "$feature_name"
  expect_pass "$feature_name" "passes_full_path_valid"
}

test_fails_when_required_file_is_missing_from_reduced_path_package() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-missing-required-file")
  rm -f "$ROOT_DIR/docs/specs/$feature_name/07-tasks.md"
  expect_fail_with "$feature_name" "fails_missing_required_file" "$feature_name/07-tasks.md: missing required spec file"
}

test_fails_when_identifier_format_is_malformed() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-malformed-id")
  sed -i 's/`REQ-01`/`REQ-1A`/' "$ROOT_DIR/docs/specs/$feature_name/01-requirements.md"
  expect_fail_with "$feature_name" "fails_malformed_id" "invalid REQ identifier format 'REQ-1A' (expected REQ-01)"
}

test_fails_when_task_verification_does_not_cover_traceable_acceptance() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-task-to-ac")
  sed -i '/TASK-01/s/`TC-01`/`TC-02`/' "$ROOT_DIR/docs/specs/$feature_name/07-tasks.md"
  expect_fail_with "$feature_name" "fails_task_to_ac" "TASK-01 verification does not cover traceable acceptance AC-01"
}

test_fails_when_acceptance_has_no_test_case_coverage() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-ac-to-tc")
  sed -i '/TC-01/s/`AC-01`/`AC-02`/' "$ROOT_DIR/docs/specs/$feature_name/09-test-cases.md"
  expect_fail_with "$feature_name" "fails_ac_to_tc" "AC-01 is not covered by any TC identifier"
}

test_fails_when_anchor_uses_template_placeholder() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-placeholder-anchor")
  sed -i 's#^- Backend process anchor files: .*#- Backend process anchor files: <repo-relative-path-or-n/a>#' "$ROOT_DIR/docs/specs/$feature_name/02-design.md"
  expect_fail_with "$feature_name" "fails_placeholder_anchor" "anchor label 'Backend process anchor files:' uses placeholder content '<repo-relative-path-or-n/a>'"
}

test_fails_when_contracts_exist_without_prose_reference() {
  feature_name=$(copy_fixture "valid-full-path" "fails-contract-reference")
  sed -i '/^## Machine-Readable Contract Files/,$d' "$ROOT_DIR/docs/specs/$feature_name/04-api-contract.md"
  build_pack_if_needed "$feature_name"
  expect_fail_with "$feature_name" "fails_contract_reference" "contracts/ exists but the prose contract spec does not reference any machine-readable contract files"
}

test_fails_when_readme_artifact_status_conflicts_with_present_contracts() {
  feature_name=$(copy_fixture "valid-full-path" "fails-classification-mismatch")
  sed -i '/`04-api-contract.md`/s/`complete`/`n\/a`/' "$ROOT_DIR/docs/specs/$feature_name/README.md"
  sed -i '/`contracts\/`/s/`complete`/`n\/a`/' "$ROOT_DIR/docs/specs/$feature_name/README.md"
  build_pack_if_needed "$feature_name"
  expect_fail_with "$feature_name" "fails_classification_mismatch" "README.md: 04-api-contract.md is marked 'n/a' but the artifact exists"
}

test_fails_when_generated_spec_pack_drifts_from_source_package() {
  feature_name=$(copy_fixture "valid-full-path" "fails-spec-pack-drift")
  build_pack_if_needed "$feature_name"
  {
    echo
    echo "- drift injected by test"
  } >> "$ROOT_DIR/docs/spec-packs/${feature_name}.pack.md"
  expect_fail_with "$feature_name" "fails_spec_pack_drift" "generated spec-pack drift detected; rebuild docs/spec-packs/${feature_name}.pack.md from the current feature package"
}

test_fails_when_implementation_report_is_missing_required_sections() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-implementation-report-sections")
  sed -i '/`11-implementation-report.md`/s/`not started`/`complete`/' "$ROOT_DIR/docs/specs/$feature_name/README.md"
  cat > "$ROOT_DIR/docs/specs/$feature_name/11-implementation-report.md" <<'EOF'
# Implementation Report

## Delivered Tasks

- `TASK-01`
EOF
  expect_fail_with "$feature_name" "fails_implementation_report_sections" "missing Acceptance And Test Traceability section"
}

test_fails_when_review_report_is_missing_required_sections() {
  feature_name=$(copy_fixture "valid-reduced-path" "fails-review-report-sections")
  sed -i '/`12-review-report.md`/s/`not started`/`complete`/' "$ROOT_DIR/docs/specs/$feature_name/README.md"
  cat > "$ROOT_DIR/docs/specs/$feature_name/12-review-report.md" <<'EOF'
# Review Report

## Review Basis

- Task profile: `review-from-rules`
EOF
  expect_fail_with "$feature_name" "fails_review_report_sections" "missing findings-by-severity section"
}

TESTS="
test_passes_when_reduced_path_fixture_meets_required_minimum
test_passes_when_full_path_fixture_and_generated_pack_are_aligned
test_fails_when_required_file_is_missing_from_reduced_path_package
test_fails_when_identifier_format_is_malformed
test_fails_when_task_verification_does_not_cover_traceable_acceptance
test_fails_when_acceptance_has_no_test_case_coverage
test_fails_when_anchor_uses_template_placeholder
test_fails_when_contracts_exist_without_prose_reference
test_fails_when_readme_artifact_status_conflicts_with_present_contracts
test_fails_when_generated_spec_pack_drifts_from_source_package
test_fails_when_implementation_report_is_missing_required_sections
test_fails_when_review_report_is_missing_required_sections
"

for test_name in $TESTS; do
  run_test "$test_name"
done

echo
echo "Test summary: $PASS_COUNT passed, $FAIL_COUNT failed"

[ "$FAIL_COUNT" -eq 0 ]

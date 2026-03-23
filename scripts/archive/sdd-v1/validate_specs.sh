#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
ISSUE_FILE=$(mktemp)
ERROR_MARKER=$(mktemp)
TAB=$(printf '\t')
trap 'rm -rf "$TMP_DIR" "$ISSUE_FILE" "$ERROR_MARKER"' EXIT HUP INT TERM
CANONICAL_SPECS_DIR="$ROOT_DIR/docs/specs"
SUPPORT_EXAMPLES_DIR="$ROOT_DIR/docs/specs-support/examples"
SUPPORT_FIXTURES_DIR="$ROOT_DIR/docs/specs-support/fixtures"

usage() {
  echo "Usage: $0 <feature-id-or-path>" >&2
  exit 1
}

resolve_feature_dir() {
  case "$1" in
    docs/specs/*|docs/specs-support/*)
      printf '%s/%s\n' "$ROOT_DIR" "$1"
      ;;
    *)
      if [ -d "$CANONICAL_SPECS_DIR/$1" ]; then
        printf '%s\n' "$CANONICAL_SPECS_DIR/$1"
      elif [ -d "$SUPPORT_EXAMPLES_DIR/$1" ]; then
        printf '%s\n' "$SUPPORT_EXAMPLES_DIR/$1"
      elif [ -d "$SUPPORT_FIXTURES_DIR/$1" ]; then
        printf '%s\n' "$SUPPORT_FIXTURES_DIR/$1"
      else
        printf '%s\n' "$CANONICAL_SPECS_DIR/$1"
      fi
      ;;
  esac
}

uppercase() {
  printf '%s' "$1" | tr '[:lower:]' '[:upper:]'
}

default_rule_source() {
  printf '%s\n' "docs/specs/README.md; docs/sdd/governance/02-minimum-completeness-before-coding.md"
}

default_why() {
  printf '%s\n' "required governed-package structure or evidence is missing, stale, or inconsistent."
}

default_next_action() {
  if [ -n "${FEATURE_REF:-}" ]; then
    printf '%s\n' "update the referenced artifact and rerun scripts/sdd/validate_specs.sh $FEATURE_REF"
  else
    printf '%s\n' "update the referenced artifact and rerun scripts/sdd/validate_specs.sh <feature-id>"
  fi
}

add_issue() {
  level=$1
  severity=$2
  message=$3
  source=${4:-$(default_rule_source)}
  why=${5:-$(default_why)}
  next=${6:-$(default_next_action)}

  printf '[%s][%s] %s\n' "$(uppercase "$level")" "$(uppercase "$severity")" "$message" >> "$ISSUE_FILE"
  printf '  Rule source: %s\n' "$source" >> "$ISSUE_FILE"
  printf '  Why: %s\n' "$why" >> "$ISSUE_FILE"
  printf '  Next action: %s\n' "$next" >> "$ISSUE_FILE"

  if [ "$level" = "error" ]; then
    printf '1\n' >> "$ERROR_MARKER"
  fi
}

add_error() {
  message=$1
  source=${2:-$(default_rule_source)}
  why=${3:-$(default_why)}
  next=${4:-$(default_next_action)}
  severity=${5:-high}

  add_issue error "$severity" "$message" "$source" "$why" "$next"
}

add_warning() {
  message=$1
  source=${2:-$(default_rule_source)}
  why=${3:-"the package is still readable, but the current framework shape has drifted from canonical expectations."}
  next=${4:-$(default_next_action)}
  severity=${5:-medium}

  add_issue warning "$severity" "$message" "$source" "$why" "$next"
}

normalize_file() {
  src=$1
  dst=$2
  tr -d '\r' < "$src" > "$dst"
}

scalar_value() {
  awk -F': *' -v key="$1" '
    {
      sub(/\r$/, "", $0)
    }
    $1 == key {
      sub($1 FS, "", $0)
      sub(/\r$/, "", $0)
      print $0
      exit
    }
  ' "$MANIFEST"
}

list_values() {
  awk -v section="$1" '
    {
      sub(/\r$/, "", $0)
    }
    $0 == section ":" {
      in_section = 1
      next
    }
    in_section && $0 ~ /^  - / {
      sub(/^  - /, "", $0)
      print
      next
    }
    in_section && $0 !~ /^  - / {
      exit
    }
  ' "$MANIFEST"
}

front_matter_list_values() {
  file=$1
  key=$2
  awk -v key="$key" '
    BEGIN {
      front_seen = 0
      in_front = 0
      in_list = 0
    }
    {
      sub(/\r$/, "", $0)
    }
    /^---$/ {
      if (front_seen == 0) {
        front_seen = 1
        in_front = 1
        next
      }
      if (in_front == 1) {
        exit
      }
    }
    in_front == 1 && $0 == key ":" {
      in_list = 1
      next
    }
    in_list == 1 && $0 ~ /^  - / {
      sub(/^  - /, "", $0)
      gsub(/^"/, "", $0)
      gsub(/"$/, "", $0)
      print $0
      next
    }
    in_list == 1 && $0 !~ /^  - / {
      exit
    }
  ' "$file"
}

path_exists() {
  item=$1
  [ -e "$ROOT_DIR/$item" ] || [ -e "$FEATURE_DIR/$item" ]
}

require_heading() {
  file=$1
  display=$2
  pattern=$3
  message=$4
  if ! grep -Eq "$pattern" "$file"; then
    add_error "$display: $message"
  fi
}

check_scope_sections() {
  file=$1
  display=$2
  if grep -Eq '^## Scope$' "$file"; then
    return
  fi
  if grep -Eq '^## In Scope$' "$file" && grep -Eq '^## Out Of Scope$' "$file"; then
    return
  fi
  add_error "$display: missing Scope section or separate In Scope and Out Of Scope sections"
}

check_rollout_sections() {
  file=$1
  display=$2
  if ! grep -Eq '^## Deployment Order$|^## Deployment Steps$' "$file"; then
    add_error "$display: missing Deployment Order or Deployment Steps section"
  fi
  if ! grep -Eq '^## Smoke Checks$|^## Release Checks$' "$file"; then
    add_error "$display: missing Smoke Checks or Release Checks section"
  fi
  if ! grep -Eq '^## Rollback$|^## Risk And Rollback$' "$file"; then
    add_error "$display: missing Rollback or Risk And Rollback section"
  fi
}

lowercase() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

is_na_status() {
  value=$(lowercase "$1")
  [ "$value" = "n/a" ] || [ "$value" = "na" ]
}

is_not_started_status() {
  value=$(lowercase "$1")
  [ "$value" = "not started" ] || [ "$value" = "not-started" ]
}

is_placeholder_anchor_value() {
  raw_value=$1
  value=$(lowercase "$raw_value")

  if is_na_status "$raw_value"; then
    return 1
  fi

  case "$value" in
    *"<"*">"*|todo|todo:*|tbd|tbd:*|placeholder|placeholder:*|fill\ in*|to\ be\ defined*|to\ be\ decided*)
      return 0
      ;;
  esac

  return 1
}

check_anchor_label() {
  file=$1
  display=$2
  label=$3
  value=$(
    awk -v label="$label" '
      {
        sub(/\r$/, "", $0)
      }
      index($0, label) {
        value = substr($0, index($0, label) + length(label))
        gsub(/^[-[:space:]]+/, "", value)
        gsub(/[[:space:]]+$/, "", value)
        print value
        exit
      }
    ' "$file"
  )
  if [ -z "$value" ]; then
    add_error "$display: missing anchor label '$label' or empty value"
    return
  fi
  if is_placeholder_anchor_value "$value"; then
    add_error "$display: anchor label '$label' uses placeholder content '$value'"
  fi
}

extract_readme_inventory() {
  file=$1
  awk -F'|' '
    function trim(text) {
      gsub(/\r$/, "", text)
      gsub(/^[[:space:]]+/, "", text)
      gsub(/[[:space:]]+$/, "", text)
      gsub(/`/, "", text)
      return text
    }
    /^\|/ {
      item = trim($2)
      if (item == "" || item == "File" || item == "---") {
        next
      }
      if (item !~ /\.md$/ && item != "contracts/" && item != "spec-pack.manifest.yaml") {
        next
      }
      required = "-"
      status = ""
      if (NF >= 7) {
        required = trim($4)
        status = trim($5)
      } else if (NF >= 5) {
        status = trim($3)
      }
      if (status == "" || status == "---") {
        next
      }
      print item "\t" required "\t" status
    }
  ' "$file"
}

inventory_has_item() {
  inventory_file=$1
  item=$2
  awk -F'\t' -v item="$item" '$1 == item { found = 1 } END { exit(found ? 0 : 1) }' "$inventory_file"
}

inventory_status() {
  inventory_file=$1
  item=$2
  awk -F'\t' -v item="$item" '$1 == item { print $3; exit }' "$inventory_file"
}

validate_front_matter_refs() {
  file=$1
  display=$2

  for key in related_specs dependencies implementation_refs test_refs; do
    list_file="$TMP_DIR/$(basename "$display").${key}.list"
    front_matter_list_values "$file" "$key" > "$list_file"

    while IFS= read -r item; do
      [ -n "$item" ] || continue
      if ! path_exists "$item"; then
        add_error \
          "$display: front matter $key references missing path '$item'" \
          "docs/sdd/templates/feature-package/README.md; docs/sdd/templates/feature-package/11-implementation-report.md; docs/sdd/templates/feature-package/12-review-report.md" \
          "front matter references are part of the package wiring and should resolve to concrete artifacts or evidence." \
          "fix the $key entry so it points to an existing repo or feature artifact, then rerun scripts/sdd/validate_specs.sh $FEATURE_REF" \
          "medium"
      fi
    done < "$list_file"
  done
}

validate_readme_inventory() {
  readme_file=$1
  inventory_file=$TMP_DIR/readme.inventory.tsv
  README_INVENTORY_FILE=$inventory_file
  extract_readme_inventory "$readme_file" > "$inventory_file"

  [ -s "$inventory_file" ] || return 0

  while IFS="$TAB" read -r item required status; do
    [ -n "$item" ] || continue

    case "$item" in
      contracts/)
        item_path=$FEATURE_DIR/contracts
        ;;
      *)
        item_path=$FEATURE_DIR/$item
        ;;
    esac

    required_lc=$(lowercase "$required")

    if is_na_status "$status"; then
      if [ -e "$item_path" ]; then
        add_error "$FEATURE_REF/README.md: $item is marked '$status' but the artifact exists"
      fi
      continue
    fi

    if [ "$required_lc" = "when implementation starts" ] && is_not_started_status "$status"; then
      if [ -e "$item_path" ]; then
        add_warning \
          "$FEATURE_REF/README.md: $item exists but is still marked '$status'" \
          "docs/specs/README.md; docs/sdd/governance/09-documentation-update-policy.md" \
          "the README artifact checklist should reflect the actual package stage so maintainers can trust package shape at a glance." \
          "update the README artifact checklist status for $item or remove the artifact if implementation has not started"
      fi
      continue
    fi
    if [ "$required_lc" = "when review starts" ] && is_not_started_status "$status"; then
      if [ -e "$item_path" ]; then
        add_warning \
          "$FEATURE_REF/README.md: $item exists but is still marked '$status'" \
          "docs/specs/README.md; docs/sdd/governance/09-documentation-update-policy.md" \
          "the README artifact checklist should reflect the actual package stage so maintainers can trust package shape at a glance." \
          "update the README artifact checklist status for $item or remove the artifact if review has not started"
      fi
      continue
    fi

    if [ ! -e "$item_path" ]; then
      add_error "$FEATURE_REF/README.md: $item is marked '$status' but the artifact is missing"
    fi
  done < "$inventory_file"

  for item in 03-data-model.md 04-api-contract.md 05-behavior.md 06-edge-cases.md 11-implementation-report.md 12-review-report.md spec-pack.manifest.yaml contracts/; do
    case "$item" in
      contracts/)
        item_path=$FEATURE_DIR/contracts
        ;;
      *)
        item_path=$FEATURE_DIR/$item
        ;;
    esac

    if [ -e "$item_path" ] && ! inventory_has_item "$inventory_file" "$item"; then
      add_error \
        "$FEATURE_REF/README.md: artifact checklist does not declare present artifact $item" \
        "docs/specs/README.md" \
        "the README artifact checklist is the canonical package-shape summary and must stay aligned with actual optional and staged artifacts." \
        "add a row for $item to the README artifact checklist so the package shape is explicit" \
        "medium"
    fi
  done
}

collect_id_candidates() {
  prefix=$1
  file=$2
  grep -oE "${prefix}-[A-Za-z0-9_-]+" "$file" 2>/dev/null | sort -u || true
}

check_id_candidates() {
  file=$1
  display=$2
  prefix=$3
  label=$4
  candidates=$(collect_id_candidates "$prefix" "$file")

  if [ -z "$candidates" ]; then
    add_error "$display: missing $label identifiers"
    return
  fi

  printf '%s\n' "$candidates" | while IFS= read -r token; do
    [ -n "$token" ] || continue
    if ! printf '%s\n' "$token" | grep -Eq "^${prefix}-[0-9][0-9]+$"; then
      add_error "$display: invalid $label identifier format '$token' (expected ${prefix}-01)"
    fi
  done
}

extract_defined_ids() {
  file=$1
  prefix=$2
  output=$3

  {
    grep -oE "^#{2,6}[[:space:]]+${prefix}-[0-9][0-9]+" "$file" 2>/dev/null | sed -E 's/^#{2,6}[[:space:]]+//'
    awk -F'|' -v prefix="$prefix" '
      function trim(text) {
        gsub(/\r$/, "", text)
        gsub(/^[[:space:]]+/, "", text)
        gsub(/[[:space:]]+$/, "", text)
        gsub(/`/, "", text)
        return text
      }
      /^\|/ {
        cell = trim($2)
        if (cell ~ ("^" prefix "-[0-9][0-9]+$")) {
          print cell
        }
      }
    ' "$file"
  } | sort -u > "$output"
}

extract_task_index() {
  file=$1
  output=$2
  awk -F'|' '
    function trim(text) {
      gsub(/\r$/, "", text)
      gsub(/^[[:space:]]+/, "", text)
      gsub(/[[:space:]]+$/, "", text)
      gsub(/`/, "", text)
      return text
    }
    /^\|/ {
      id = trim($2)
      if (id ~ /^TASK-[0-9][0-9]+$/) {
        print id "\t" trim($4) "\t" trim($5) "\t" trim($6)
      }
    }
  ' "$file" > "$output"
}

extract_ac_index() {
  file=$1
  output=$2
  {
    awk -F'|' '
      function trim(text) {
        gsub(/\r$/, "", text)
        gsub(/^[[:space:]]+/, "", text)
        gsub(/[[:space:]]+$/, "", text)
        gsub(/`/, "", text)
        return text
      }
      /^\|/ {
        id = trim($2)
        if (id ~ /^AC-[0-9][0-9]+$/) {
          print id "\t" trim($3)
        }
      }
    ' "$file"
    awk '
      function trim(text) {
        gsub(/\r$/, "", text)
        gsub(/^[[:space:]]+/, "", text)
        gsub(/[[:space:]]+$/, "", text)
        gsub(/`/, "", text)
        return text
      }
      function flush() {
        if (id != "") {
          print id "\t" links
        }
      }
      /^#{2,6}[[:space:]]+AC-[0-9][0-9]+/ {
        flush()
        header = trim($0)
        split(header, parts, /[[:space:]]+/)
        id = parts[2]
        links = ""
        next
      }
      id != "" && /Requirement links:/ {
        line = trim($0)
        sub(/^.*Requirement links:[[:space:]]*/, "", line)
        links = line
      }
      END {
        flush()
      }
    ' "$file"
  } | awk -F'\t' '!seen[$1]++' > "$output"
}

extract_tc_index() {
  file=$1
  output=$2
  {
    awk -F'|' '
      function trim(text) {
        gsub(/\r$/, "", text)
        gsub(/^[[:space:]]+/, "", text)
        gsub(/[[:space:]]+$/, "", text)
        gsub(/`/, "", text)
        return text
      }
      /^\|/ {
        id = trim($2)
        if (id ~ /^TC-[0-9][0-9]+$/) {
          print id "\t" trim($3)
        }
      }
    ' "$file"
    awk '
      function trim(text) {
        gsub(/\r$/, "", text)
        gsub(/^[[:space:]]+/, "", text)
        gsub(/[[:space:]]+$/, "", text)
        gsub(/`/, "", text)
        return text
      }
      function flush() {
        if (id != "") {
          print id "\t" links
        }
      }
      /^#{2,6}[[:space:]]+TC-[0-9][0-9]+/ {
        flush()
        header = trim($0)
        split(header, parts, /[[:space:]]+/)
        id = parts[2]
        links = ""
        next
      }
      id != "" && /Acceptance link:/ {
        line = trim($0)
        sub(/^.*Acceptance link:[[:space:]]*/, "", line)
        links = line
      }
      id != "" && /Acceptance links:/ {
        line = trim($0)
        sub(/^.*Acceptance links:[[:space:]]*/, "", line)
        links = line
      }
      END {
        flush()
      }
    ' "$file"
  } | awk -F'\t' '!seen[$1]++' > "$output"
}

extract_readme_traceability() {
  file=$1
  output=$2
  awk -F'|' '
    function trim(text) {
      gsub(/\r$/, "", text)
      gsub(/^[[:space:]]+/, "", text)
      gsub(/[[:space:]]+$/, "", text)
      gsub(/`/, "", text)
      return text
    }
    /^\|/ {
      requirement = trim($2)
      if (requirement ~ /^REQ-[0-9][0-9]+$/) {
        print requirement "\t" trim($3) "\t" trim($4) "\t" trim($5) "\t" trim($6)
      }
    }
  ' "$file" > "$output"
}

validate_reference_text() {
  display=$1
  source_id=$2
  prefix=$3
  refs=$4
  defs_file=$5
  relation_label=$6

  tokens=$(printf '%s\n' "$refs" | grep -oE "${prefix}-[A-Za-z0-9_-]+" 2>/dev/null | sort -u || true)

  if [ -z "$tokens" ]; then
    add_error "$display: $source_id missing $relation_label"
    return
  fi

  printf '%s\n' "$tokens" | while IFS= read -r token; do
    [ -n "$token" ] || continue

    if ! printf '%s\n' "$token" | grep -Eq "^${prefix}-[0-9][0-9]+$"; then
      add_error "$display: $source_id has invalid $relation_label identifier '$token' (expected ${prefix}-01)"
      continue
    fi

    if ! grep -Fxq "$token" "$defs_file"; then
      add_error "$display: $source_id references undefined $token in $relation_label"
    fi
  done
}

lookup_index_field() {
  index_file=$1
  key=$2
  field_no=$3
  awk -F'\t' -v key="$key" -v field_no="$field_no" '$1 == key { print $field_no; exit }' "$index_file"
}

lookup_traceability_refs() {
  index_file=$1
  key=$2
  key_field=$3
  result_field=$4
  awk -F'\t' -v key="$key" -v key_field="$key_field" -v result_field="$result_field" '
    index($key_field, key) {
      print $result_field
    }
  ' "$index_file"
}

check_generated_pack_drift() {
  [ -n "${OUTPUT:-}" ] || return 0

  expected_output="$TMP_DIR/generated-pack.expected.md"
  build_log="$TMP_DIR/generated-pack.build.log"
  actual_output="$ROOT_DIR/$OUTPUT"

  if ! SPEC_PACK_OUTPUT_OVERRIDE="$expected_output" sh "$ROOT_DIR/scripts/sdd/build_spec_pack.sh" "$FEATURE_REF" > "$build_log" 2>&1; then
    add_error \
      "$FEATURE_REF/spec-pack.manifest.yaml: could not rebuild generated spec-pack for drift check" \
      "docs/specs/README.md; docs/sdd/templates/spec-pack-template.md" \
      "the drift check depends on rebuilding the generated spec-pack from canonical inputs, so a rebuild failure blocks reliable comparison." \
      "fix the manifest or build_spec_pack inputs, then rerun scripts/sdd/validate_specs.sh $FEATURE_REF" \
      "high"
    sed 's/^/  build_spec_pack: /' "$build_log" >> "$ISSUE_FILE"
    return
  fi

  normalize_file "$expected_output" "$TMP_DIR/generated-pack.expected.normalized.md"
  normalize_file "$actual_output" "$TMP_DIR/generated-pack.actual.normalized.md"

  if ! cmp -s "$TMP_DIR/generated-pack.expected.normalized.md" "$TMP_DIR/generated-pack.actual.normalized.md"; then
    add_error "$FEATURE_REF/spec-pack.manifest.yaml: generated spec-pack drift detected; rebuild $OUTPUT from the current feature package"
  fi
}

check_contract_artifacts() {
  contract_dir=$FEATURE_DIR/contracts

  [ -d "$contract_dir" ] || return 0

  if ! find "$contract_dir" -type f | grep -q .; then
    add_error "$FEATURE_REF/contracts/: directory exists but contains no contract files"
  fi

  if [ ! -f "$FEATURE_DIR/04-api-contract.md" ]; then
    add_error "$FEATURE_REF/04-api-contract.md: contracts/ exists, so the prose contract spec is required"
  elif ! grep -Eq 'contracts/[A-Za-z0-9._/-]+' "$API_FILE"; then
    add_error "$FEATURE_REF/04-api-contract.md: contracts/ exists but the prose contract spec does not reference any machine-readable contract files"
  fi

  if [ -f "$MANIFEST" ]; then
    list_values contracts > "$TMP_DIR/manifest.contracts.list"
    if [ ! -s "$TMP_DIR/manifest.contracts.list" ]; then
      add_error "$FEATURE_REF/spec-pack.manifest.yaml: contracts/ exists but the contracts section is empty"
    fi
  fi
}

check_referenced_contract_paths() {
  [ -f "$API_FILE" ] || return 0

  grep -oE 'contracts/[A-Za-z0-9._/-]+' "$API_FILE" 2>/dev/null | sort -u > "$TMP_DIR/api.contract.refs"
  [ -s "$TMP_DIR/api.contract.refs" ] || return 0

  while IFS= read -r contract_ref; do
    [ -n "$contract_ref" ] || continue
    if ! path_exists "$contract_ref"; then
      add_error \
        "$FEATURE_REF/04-api-contract.md: referenced contract artifact not found: $contract_ref" \
        "docs/specs/README.md; docs/sdd/governance/09-documentation-update-policy.md" \
        "contract references should resolve to actual owned artifacts so prose and machine-readable shapes do not drift silently." \
        "add the missing contract artifact or correct the referenced path in 04-api-contract.md" \
        "high"
    fi
  done < "$TMP_DIR/api.contract.refs"
}

report_should_be_checked() {
  item=$1
  file_path=$2

  if [ -f "$file_path" ]; then
    return 0
  fi

  if [ -n "${README_INVENTORY_FILE:-}" ] && [ -f "$README_INVENTORY_FILE" ]; then
    status=$(inventory_status "$README_INVENTORY_FILE" "$item")
    if [ -n "$status" ] && ! is_not_started_status "$status" && ! is_na_status "$status"; then
      return 0
    fi
  fi

  return 1
}

require_report_heading() {
  file=$1
  display=$2
  pattern=$3
  message=$4
  source=$5
  why=$6
  next=$7
  level=$8
  severity=$9

  if grep -Eq "$pattern" "$file"; then
    return 0
  fi

  if [ "$level" = "warning" ]; then
    add_warning "$display: $message" "$source" "$why" "$next" "$severity"
  else
    add_error "$display: $message" "$source" "$why" "$next" "$severity"
  fi
}

validate_implementation_report() {
  report_path=$FEATURE_DIR/11-implementation-report.md
  display=$FEATURE_REF/11-implementation-report.md

  report_should_be_checked "11-implementation-report.md" "$report_path" || return 0
  [ -f "$report_path" ] || return 0

  report_file="$TMP_DIR/11-implementation-report.normalized.md"
  normalize_file "$report_path" "$report_file"
  validate_front_matter_refs "$report_file" "$display"

  baseline_source="docs/sdd/governance/03-implementation-traceability-rules.md; docs/sdd/governance/definition-of-done.md"
  baseline_why="implementation evidence must identify delivered work, acceptance or test traceability, and verification results before a completion claim is safe."
  baseline_next="add the missing implementation-report section or evidence marker, then rerun scripts/sdd/validate_specs.sh $FEATURE_REF"

  require_report_heading "$report_file" "$display" '^# Implementation Report$' "missing Implementation Report heading" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Delivered Scope Status$|^## Delivered Tasks$|^## Changes Made$' "missing delivered-implementation section (expected Delivered Scope Status, Delivered Tasks, or Changes Made)" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Acceptance And Test Traceability$' "missing Acceptance And Test Traceability section" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Validations And Tests Run$|^## Verification Summary$' "missing validation summary section (expected Validations And Tests Run or Verification Summary)" "$baseline_source" "$baseline_why" "$baseline_next" error high

  template_source="docs/sdd/templates/feature-package/11-implementation-report.md"
  template_why="the current implementation-report template requires explicit scope, evidence, conflict, self-review, and confidence sections so AI-assisted work remains auditable."
  template_next="upgrade the implementation report to the current canonical template sections or record the drift explicitly in a follow-up"

  require_report_heading "$report_file" "$display" '^## Implementation Scope$' "missing current-template section Implementation Scope" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Governing Artifacts Used$' "missing current-template section Governing Artifacts Used" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Supporting Evidence Used$' "missing current-template section Supporting Evidence Used" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Code Areas Inspected$' "missing current-template section Code Areas Inspected" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Contract Or Interface Impact$' "missing current-template section Contract Or Interface Impact" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Assumptions$' "missing current-template section Assumptions" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Conflicts Found$|^## Deviations$' "missing conflict or deviation section" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Residual Risks$' "missing current-template section Residual Risks" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Self-Review Summary$' "missing current-template section Self-Review Summary" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Completion Self-Check$' "missing current-template section Completion Self-Check" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Confidence Summary$' "missing current-template section Confidence Summary" "$template_source" "$template_why" "$template_next" warning medium
}

validate_review_report() {
  report_path=$FEATURE_DIR/12-review-report.md
  display=$FEATURE_REF/12-review-report.md

  report_should_be_checked "12-review-report.md" "$report_path" || return 0
  [ -f "$report_path" ] || return 0

  report_file="$TMP_DIR/12-review-report.normalized.md"
  normalize_file "$report_path" "$report_file"
  validate_front_matter_refs "$report_file" "$display"

  baseline_source="docs/sdd/governance/04-review-rules.md; docs/sdd/governance/definition-of-done.md"
  baseline_why="review evidence must identify its basis, findings, and verdict so reviewers can defend the review outcome."
  baseline_next="add the missing review-report section or evidence marker, then rerun scripts/sdd/validate_specs.sh $FEATURE_REF"

  require_report_heading "$report_file" "$display" '^# .*Review Report.*$' "missing Review Report heading" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Review Basis$|^## Review scope$|^## Review Scope$|^## Review basis / evidence used$|^## Review Basis / Evidence Used$' "missing review-basis section" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Findings By Severity$|^## Findings by severity$' "missing findings-by-severity section" "$baseline_source" "$baseline_why" "$baseline_next" error high
  require_report_heading "$report_file" "$display" '^## Verdict$|^## Recommended next action$|^## Recommended Next Action$' "missing verdict or recommended-next-action section" "$baseline_source" "$baseline_why" "$baseline_next" error high

  template_source="docs/sdd/templates/feature-package/12-review-report.md"
  template_why="the current review-report template requires explicit hallucination checks, contract drift checks, traceability checks, test evidence, and verdict structure so reviews stay auditable."
  template_next="upgrade the review report to the current canonical template sections or record the drift explicitly in a follow-up"

  require_report_heading "$report_file" "$display" '^## Hallucination And Unsupported-Assumption Check$' "missing current-template section Hallucination And Unsupported-Assumption Check" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Contract Drift Check$' "missing current-template section Contract Drift Check" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Traceability Check$' "missing current-template section Traceability Check" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Test Evidence Check$' "missing current-template section Test Evidence Check" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Observed Facts$' "missing current-template section Observed Facts" "$template_source" "$template_why" "$template_next" warning medium
  require_report_heading "$report_file" "$display" '^## Residual Risks$' "missing current-template section Residual Risks" "$template_source" "$template_why" "$template_next" warning medium

  if ! grep -Eq 'Automation note:|\[NO-AUTOMATED-TESTS\]' "$report_file"; then
    add_warning \
      "$display: missing automation evidence marker (expected 'Automation note:' or '[NO-AUTOMATED-TESTS]')" \
      "docs/sdd/governance/04-review-rules.md; docs/sdd/templates/feature-package/12-review-report.md" \
      "review reports should make test automation limits explicit so operators do not over-read the evidence depth." \
      "record an Automation note or add [NO-AUTOMATED-TESTS] where automation is absent"
  fi
}

[ $# -eq 1 ] || usage

ARG=$1
FEATURE_DIR=$(resolve_feature_dir "$ARG")

[ -d "$FEATURE_DIR" ] || {
  echo "Feature directory not found: $FEATURE_DIR" >&2
  exit 1
}

FEATURE_REF=$(printf '%s\n' "$FEATURE_DIR" | sed "s#^$ROOT_DIR/##")

for name in README.md 01-requirements.md 02-design.md 07-tasks.md 08-acceptance-criteria.md 09-test-cases.md 10-rollout.md changelog.md; do
  if [ ! -f "$FEATURE_DIR/$name" ]; then
    add_error "$FEATURE_REF/$name: missing required spec file"
  else
    normalize_file "$FEATURE_DIR/$name" "$TMP_DIR/$name"
  fi
done

for name in 03-data-model.md 04-api-contract.md 05-behavior.md 06-edge-cases.md 11-implementation-report.md 12-review-report.md; do
  if [ -f "$FEATURE_DIR/$name" ]; then
    normalize_file "$FEATURE_DIR/$name" "$TMP_DIR/$name"
  fi
done

README_FILE="$TMP_DIR/README.md"
REQ_FILE="$TMP_DIR/01-requirements.md"
DESIGN_FILE="$TMP_DIR/02-design.md"
DATA_MODEL_FILE="$TMP_DIR/03-data-model.md"
API_FILE="$TMP_DIR/04-api-contract.md"
TASK_FILE="$TMP_DIR/07-tasks.md"
AC_FILE="$TMP_DIR/08-acceptance-criteria.md"
TC_FILE="$TMP_DIR/09-test-cases.md"
ROLLOUT_FILE="$TMP_DIR/10-rollout.md"

if [ -f "$README_FILE" ]; then
  require_heading "$README_FILE" "$FEATURE_REF/README.md" '^## Summary$' "missing Summary section"
  require_heading "$README_FILE" "$FEATURE_REF/README.md" '^## Scope$' "missing Scope section"
  require_heading "$README_FILE" "$FEATURE_REF/README.md" '^## Traceability Summary$|^## Traceability$' "missing Traceability Summary or Traceability section"
  validate_front_matter_refs "$README_FILE" "$FEATURE_REF/README.md"
  validate_readme_inventory "$README_FILE"
fi

if [ -f "$REQ_FILE" ]; then
  validate_front_matter_refs "$REQ_FILE" "$FEATURE_REF/01-requirements.md"
  require_heading "$REQ_FILE" "$FEATURE_REF/01-requirements.md" '^## Problem Statement$|^## Problem$|^# Requirements$' "missing Problem Statement, Problem, or primary Requirements heading"
  check_scope_sections "$REQ_FILE" "$FEATURE_REF/01-requirements.md"
  require_heading "$REQ_FILE" "$FEATURE_REF/01-requirements.md" '^## Requirements$|^# Requirements$' "missing Requirements section"
  require_heading "$REQ_FILE" "$FEATURE_REF/01-requirements.md" '^## Constraints$|^## Assumptions And Constraints$' "missing Constraints section"
  check_id_candidates "$REQ_FILE" "$FEATURE_REF/01-requirements.md" "REQ" "REQ"
fi

if [ -f "$DESIGN_FILE" ]; then
  validate_front_matter_refs "$DESIGN_FILE" "$FEATURE_REF/02-design.md"
  require_heading "$DESIGN_FILE" "$FEATURE_REF/02-design.md" '^## Overview$' "missing Overview section"
  require_heading "$DESIGN_FILE" "$FEATURE_REF/02-design.md" '^## Design Decisions$' "missing Design Decisions section"
  require_heading "$DESIGN_FILE" "$FEATURE_REF/02-design.md" '^## Source Base Anchors$' "missing Source Base Anchors section"
  check_id_candidates "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "REQ" "REQ"
  check_id_candidates "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "DES" "DES"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "Backend process anchor files:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "Backend webservice anchor files:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "SQL anchor files:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "Frontend .ts anchor files:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "Frontend .html anchor files:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "Dominant module/style note:"
  check_anchor_label "$DESIGN_FILE" "$FEATURE_REF/02-design.md" "New tables/source families/screen structure in scope:"
fi

if [ -f "$TASK_FILE" ]; then
  validate_front_matter_refs "$TASK_FILE" "$FEATURE_REF/07-tasks.md"
  require_heading "$TASK_FILE" "$FEATURE_REF/07-tasks.md" '^# Tasks$' "missing Tasks heading"
  require_heading "$TASK_FILE" "$FEATURE_REF/07-tasks.md" '^## Sequencing$|^## Delivery Plan$' "missing Sequencing or Delivery Plan section"
  check_id_candidates "$TASK_FILE" "$FEATURE_REF/07-tasks.md" "TASK" "TASK"
  check_id_candidates "$TASK_FILE" "$FEATURE_REF/07-tasks.md" "REQ" "REQ"
  check_id_candidates "$TASK_FILE" "$FEATURE_REF/07-tasks.md" "DES" "DES"
  task_tc_candidates=$(collect_id_candidates "TC" "$TASK_FILE")
  if [ -n "$task_tc_candidates" ]; then
    check_id_candidates "$TASK_FILE" "$FEATURE_REF/07-tasks.md" "TC" "TC"
  elif [ -f "$README_FILE" ]; then
    readme_tc_candidates=$(collect_id_candidates "TC" "$README_FILE")
    if [ -z "$readme_tc_candidates" ]; then
      add_error "$FEATURE_REF/07-tasks.md: missing TC identifiers"
    fi
  else
    add_error "$FEATURE_REF/07-tasks.md: missing TC identifiers"
  fi
fi

if [ -f "$AC_FILE" ]; then
  validate_front_matter_refs "$AC_FILE" "$FEATURE_REF/08-acceptance-criteria.md"
  require_heading "$AC_FILE" "$FEATURE_REF/08-acceptance-criteria.md" '^# Acceptance Criteria$' "missing Acceptance Criteria heading"
  check_id_candidates "$AC_FILE" "$FEATURE_REF/08-acceptance-criteria.md" "AC" "AC"
  check_id_candidates "$AC_FILE" "$FEATURE_REF/08-acceptance-criteria.md" "REQ" "REQ"
fi

if [ -f "$TC_FILE" ]; then
  validate_front_matter_refs "$TC_FILE" "$FEATURE_REF/09-test-cases.md"
  require_heading "$TC_FILE" "$FEATURE_REF/09-test-cases.md" '^# Test Cases$' "missing Test Cases heading"
  check_id_candidates "$TC_FILE" "$FEATURE_REF/09-test-cases.md" "TC" "TC"
  check_id_candidates "$TC_FILE" "$FEATURE_REF/09-test-cases.md" "AC" "AC"
fi

if [ -f "$ROLLOUT_FILE" ]; then
  validate_front_matter_refs "$ROLLOUT_FILE" "$FEATURE_REF/10-rollout.md"
  check_rollout_sections "$ROLLOUT_FILE" "$FEATURE_REF/10-rollout.md"
fi

REQ_DEFS="$TMP_DIR/req.defs"
DES_DEFS="$TMP_DIR/des.defs"
TASK_DEFS="$TMP_DIR/task.defs"
AC_DEFS="$TMP_DIR/ac.defs"
TC_DEFS="$TMP_DIR/tc.defs"
TASK_INDEX="$TMP_DIR/task.index.tsv"
AC_INDEX="$TMP_DIR/ac.index.tsv"
TC_INDEX="$TMP_DIR/tc.index.tsv"
README_TRACEABILITY_INDEX="$TMP_DIR/readme.traceability.tsv"

if [ -f "$REQ_FILE" ] && [ -f "$DESIGN_FILE" ] && [ -f "$TASK_FILE" ] && [ -f "$AC_FILE" ] && [ -f "$TC_FILE" ]; then
  extract_defined_ids "$REQ_FILE" "REQ" "$REQ_DEFS"
  extract_defined_ids "$DESIGN_FILE" "DES" "$DES_DEFS"
  extract_defined_ids "$TASK_FILE" "TASK" "$TASK_DEFS"
  extract_defined_ids "$AC_FILE" "AC" "$AC_DEFS"
  extract_defined_ids "$TC_FILE" "TC" "$TC_DEFS"

  [ -s "$REQ_DEFS" ] || add_error "$FEATURE_REF/01-requirements.md: missing REQ definitions"
  [ -s "$DES_DEFS" ] || add_error "$FEATURE_REF/02-design.md: missing DES definitions"
  [ -s "$TASK_DEFS" ] || add_error "$FEATURE_REF/07-tasks.md: missing TASK definitions"
  [ -s "$AC_DEFS" ] || add_error "$FEATURE_REF/08-acceptance-criteria.md: missing AC definitions"
  [ -s "$TC_DEFS" ] || add_error "$FEATURE_REF/09-test-cases.md: missing TC definitions"

  extract_task_index "$TASK_FILE" "$TASK_INDEX"
  extract_ac_index "$AC_FILE" "$AC_INDEX"
  extract_tc_index "$TC_FILE" "$TC_INDEX"
  extract_readme_traceability "$README_FILE" "$README_TRACEABILITY_INDEX"

  while IFS="$TAB" read -r task_id task_reqs task_designs task_tcs; do
    [ -n "$task_id" ] || continue
    validate_reference_text "$FEATURE_REF/07-tasks.md" "$task_id" "REQ" "$task_reqs" "$REQ_DEFS" "Requirement Links"
    validate_reference_text "$FEATURE_REF/07-tasks.md" "$task_id" "DES" "$task_designs" "$DES_DEFS" "Design Links"

    effective_task_tcs=$task_tcs
    task_tc_tokens=$(printf '%s\n' "$effective_task_tcs" | grep -oE 'TC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u || true)
    if [ -z "$task_tc_tokens" ] && [ -s "$README_TRACEABILITY_INDEX" ]; then
      effective_task_tcs=$(lookup_traceability_refs "$README_TRACEABILITY_INDEX" "$task_id" 3 5)
      task_tc_tokens=$(printf '%s\n' "$effective_task_tcs" | grep -oE 'TC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u || true)
    fi
    validate_reference_text "$FEATURE_REF/07-tasks.md" "$task_id" "TC" "$effective_task_tcs" "$TC_DEFS" "Verification links"

    derived_acs_file="$TMP_DIR/${task_id}.derived-acs"
    : > "$derived_acs_file"
    if [ -n "$task_tc_tokens" ]; then
      printf '%s\n' "$task_tc_tokens" | while IFS= read -r tc_id; do
        [ -n "$tc_id" ] || continue
        tc_acs=$(lookup_index_field "$TC_INDEX" "$tc_id" 2)
        printf '%s\n' "$tc_acs" | grep -oE 'AC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u >> "$derived_acs_file" || true
      done
    fi
    if [ ! -s "$derived_acs_file" ] && [ -s "$README_TRACEABILITY_INDEX" ]; then
      lookup_traceability_refs "$README_TRACEABILITY_INDEX" "$task_id" 3 4 | grep -oE 'AC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u >> "$derived_acs_file" || true
    fi
    sort -u "$derived_acs_file" -o "$derived_acs_file"
    if [ ! -s "$derived_acs_file" ]; then
      add_error "$FEATURE_REF/07-tasks.md: $task_id verification TCs do not resolve to any AC identifiers"
    fi

    if [ -s "$README_TRACEABILITY_INDEX" ]; then
      expected_acs_file="$TMP_DIR/${task_id}.expected-acs"
      : > "$expected_acs_file"
      lookup_traceability_refs "$README_TRACEABILITY_INDEX" "$task_id" 3 4 | grep -oE 'AC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u > "$expected_acs_file" || true
      if [ -s "$expected_acs_file" ]; then
        while IFS= read -r expected_ac; do
          [ -n "$expected_ac" ] || continue
          if ! grep -Fxq "$expected_ac" "$derived_acs_file"; then
            add_error "$FEATURE_REF/07-tasks.md: $task_id verification does not cover traceable acceptance $expected_ac"
          fi
        done < "$expected_acs_file"
      fi
    fi
  done < "$TASK_INDEX"

  while IFS="$TAB" read -r ac_id ac_reqs; do
    [ -n "$ac_id" ] || continue
    validate_reference_text "$FEATURE_REF/08-acceptance-criteria.md" "$ac_id" "REQ" "$ac_reqs" "$REQ_DEFS" "Requirement Links"

    ac_covered=0
    while IFS="$TAB" read -r tc_id tc_acs; do
      [ -n "$tc_id" ] || continue
      tc_ac_tokens=$(printf '%s\n' "$tc_acs" | grep -oE 'AC-[A-Za-z0-9_-]+' 2>/dev/null | sort -u || true)
      if [ -n "$tc_ac_tokens" ] && printf '%s\n' "$tc_ac_tokens" | grep -Fxq "$ac_id"; then
        ac_covered=1
        break
      fi
    done < "$TC_INDEX"

    if [ "$ac_covered" -eq 0 ]; then
      add_error "$FEATURE_REF/08-acceptance-criteria.md: $ac_id is not covered by any TC identifier"
    fi
  done < "$AC_INDEX"

  while IFS="$TAB" read -r tc_id tc_acs; do
    [ -n "$tc_id" ] || continue
    validate_reference_text "$FEATURE_REF/09-test-cases.md" "$tc_id" "AC" "$tc_acs" "$AC_DEFS" "Acceptance Links"
  done < "$TC_INDEX"
fi

MANIFEST="$FEATURE_DIR/spec-pack.manifest.yaml"
if [ -f "$MANIFEST" ]; then
  FEATURE_ID=$(scalar_value feature_id)
  TITLE=$(scalar_value title)
  STATUS=$(scalar_value status)
  OUTPUT=$(scalar_value output)

  [ -n "$FEATURE_ID" ] || add_error "$FEATURE_REF/spec-pack.manifest.yaml: missing required key feature_id"
  [ -n "$TITLE" ] || add_error "$FEATURE_REF/spec-pack.manifest.yaml: missing required key title"
  [ -n "$STATUS" ] || add_error "$FEATURE_REF/spec-pack.manifest.yaml: missing required key status"
  [ -n "$OUTPUT" ] || add_error "$FEATURE_REF/spec-pack.manifest.yaml: missing required key output"

  for group in entrypoints context standards specs contracts; do
    list_values "$group" > "$TMP_DIR/$group.list"
    while IFS= read -r item; do
      [ -n "$item" ] || continue
      if ! path_exists "$item"; then
        add_error "$FEATURE_REF/spec-pack.manifest.yaml: referenced file not found: $item"
      fi
    done < "$TMP_DIR/$group.list"
  done

  if [ -n "${OUTPUT:-}" ]; then
    OUTPUT_PATH="$ROOT_DIR/$OUTPUT"
    if [ ! -f "$OUTPUT_PATH" ]; then
      add_error "$FEATURE_REF/spec-pack.manifest.yaml: missing generated spec-pack $OUTPUT"
    else
      normalize_file "$OUTPUT_PATH" "$TMP_DIR/generated-pack.md"
      require_heading "$TMP_DIR/generated-pack.md" "$OUTPUT" '^# Generated Spec Pack$' "missing generated pack title marker"
      require_heading "$TMP_DIR/generated-pack.md" "$OUTPUT" '^## Source Base Anchors$' "missing Source Base Anchors section"
      require_heading "$TMP_DIR/generated-pack.md" "$OUTPUT" '^## Scope Guardrails$' "missing Scope Guardrails section"
      require_heading "$TMP_DIR/generated-pack.md" "$OUTPUT" '^## Traceability Snapshot$' "missing Traceability Snapshot section"
      require_heading "$TMP_DIR/generated-pack.md" "$OUTPUT" '^## Implementation Constraints$|^## Execution Constraints$' "missing Implementation Constraints or Execution Constraints section"
      check_generated_pack_drift
    fi
  fi
fi

check_contract_artifacts
check_referenced_contract_paths
validate_implementation_report
validate_review_report

if [ -s "$ISSUE_FILE" ]; then
  if [ -s "$ERROR_MARKER" ]; then
    echo "Spec validation failed for $FEATURE_REF" >&2
    cat "$ISSUE_FILE" >&2
    exit 1
  fi

  echo "Spec validation passed with warnings for $FEATURE_REF"
  cat "$ISSUE_FILE"
  exit 0
fi

if [ -s "$ERROR_MARKER" ]; then
  echo "Spec validation failed for $FEATURE_REF" >&2
  cat "$ISSUE_FILE" >&2
  exit 1
fi

echo "Spec validation passed for $FEATURE_REF"

#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM
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

resolve_path() {
  item=$1
  if [ -f "$ROOT_DIR/$item" ]; then
    printf '%s\n' "$ROOT_DIR/$item"
    return
  fi
  if [ -f "$FEATURE_DIR/$item" ]; then
    printf '%s\n' "$FEATURE_DIR/$item"
    return
  fi
  echo "Referenced file not found: $item" >&2
  exit 1
}

relative_path() {
  printf '%s\n' "$1" | sed "s#^$ROOT_DIR/##"
}

summarize_markdown() {
  path_to_summary=$1
  source_ref=$2
  max_bullets=${3:-8}
  awk -v file_ref="$source_ref" -v max="$max_bullets" '
    BEGIN {
      count = 0
      in_front_matter = 0
      front_seen = 0
    }
    /^---$/ {
      if (front_seen == 0) {
        in_front_matter = 1
        front_seen = 1
        next
      }
      if (in_front_matter == 1) {
        in_front_matter = 0
        next
      }
    }
    in_front_matter == 1 { next }
    /^#/ { next }
    /^\|/ {
      if (count < max) {
        print "- Table content kept in source: `" file_ref "`"
        count++
      }
      exit
    }
    /^[[:space:]]*$/ { next }
    {
      line = $0
      sub(/^[[:space:]-]+/, "", line)
      sub(/[[:space:]]+$/, "", line)
      if (line == "") {
        next
      }
      print "- " line
      count++
      if (count >= max) {
        exit
      }
    }
    END {
      if (count == 0) {
        print "- See source: `" file_ref "`"
      }
    }
  ' "$path_to_summary"
}

extract_markdown_section() {
  src=$1
  pattern=$2
  dst=$3
  awk -v pattern="$pattern" '
    {
      sub(/\r$/, "", $0)
    }
    $0 ~ /^## / {
      if (in_section && $0 !~ pattern) {
        exit
      }
      if ($0 ~ pattern) {
        in_section = 1
        next
      }
    }
    in_section {
      print
    }
  ' "$src" > "$dst"
}

anchor_value() {
  label=$1
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
  ' "$DESIGN_FILE"
}

print_manifest_list() {
  section=$1
  fallback=$2
  count=0
  list_file="$TMP_DIR/$section.list"
  list_values "$section" > "$list_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    resolved=$(resolve_path "$item")
    echo "- \`$(relative_path "$resolved")\`"
    count=$((count + 1))
  done < "$list_file"
  if [ "$count" -eq 0 ]; then
    echo "- $fallback"
  fi
}

print_manifest_summaries() {
  section=$1
  heading_prefix=$2
  max_bullets=$3
  list_file="$TMP_DIR/$section.summary.list"
  list_values "$section" > "$list_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    resolved=$(resolve_path "$item")
    echo "## $heading_prefix: $(basename "$resolved")"
    echo
    summarize_markdown "$resolved" "$(relative_path "$resolved")" "$max_bullets"
    echo
  done < "$list_file"
}

[ $# -eq 1 ] || usage

ARG=$1
FEATURE_DIR=$(resolve_feature_dir "$ARG")

MANIFEST="$FEATURE_DIR/spec-pack.manifest.yaml"
[ -f "$MANIFEST" ] || {
  echo "Missing manifest: $MANIFEST" >&2
  exit 1
}

FEATURE_ID=$(scalar_value feature_id)
TITLE=$(scalar_value title)
STATUS=$(scalar_value status)
OUTPUT=$(scalar_value output)

[ -n "$FEATURE_ID" ] || { echo "Manifest missing required key: feature_id" >&2; exit 1; }
[ -n "$TITLE" ] || { echo "Manifest missing required key: title" >&2; exit 1; }
[ -n "$STATUS" ] || { echo "Manifest missing required key: status" >&2; exit 1; }
[ -n "$OUTPUT" ] || { echo "Manifest missing required key: output" >&2; exit 1; }

OUTPUT_PATH=${SPEC_PACK_OUTPUT_OVERRIDE:-$ROOT_DIR/$OUTPUT}
README_FILE="$FEATURE_DIR/README.md"
DESIGN_FILE="$FEATURE_DIR/02-design.md"
mkdir -p "$(dirname "$OUTPUT_PATH")"

TRACEABILITY_SECTION="$TMP_DIR/traceability.md"
README_SCOPE_SECTION="$TMP_DIR/readme-scope.md"
DESIGN_NON_CHANGES_SECTION="$TMP_DIR/design-non-changes.md"
README_OPEN_QUESTIONS_SECTION="$TMP_DIR/readme-open-questions.md"
extract_markdown_section "$README_FILE" "^## Traceability Summary$|^## Traceability$" "$TRACEABILITY_SECTION"
extract_markdown_section "$README_FILE" "^## Scope$|^## In Scope$|^## Out Of Scope$" "$README_SCOPE_SECTION"
extract_markdown_section "$DESIGN_FILE" "^## Non-Changes$" "$DESIGN_NON_CHANGES_SECTION"
extract_markdown_section "$README_FILE" "^## Open Questions$" "$README_OPEN_QUESTIONS_SECTION"

{
  echo "# Generated Spec Pack"
  echo
  echo "- Feature: \`$FEATURE_ID\`"
  echo "- Source manifest: \`$(relative_path "$MANIFEST")\`"
  echo "- Source package: \`$(relative_path "$FEATURE_DIR")/\`"
  echo "- Status: \`$STATUS\`"
  echo "- Purpose: agent execution and review aid; the feature package remains the governance source of truth"
  echo
  echo "## Entry Points"
  echo
  print_manifest_list entrypoints "\`AGENTS.md\`"
  echo

  echo "## Loading Context"
  echo
  print_manifest_list context "No context declared"
  echo

  print_manifest_summaries context "Context Summary" 6

  echo "## Relevant Standards"
  echo
  print_manifest_list standards "No standards declared"
  echo

  print_manifest_summaries standards "Standard Summary" 5

  echo "## Feature Summary"
  echo
  echo "- Title: \`$TITLE\`"
  specs_file="$TMP_DIR/specs.list"
  list_values specs > "$specs_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    resolved=$(resolve_path "$item")
    echo "- Source: \`$(relative_path "$resolved")\`"
  done < "$specs_file"
  echo

  echo "## Source Base Anchors"
  echo
  echo "- Backend process anchor files: $(anchor_value "Backend process anchor files:")"
  echo "- Backend webservice anchor files: $(anchor_value "Backend webservice anchor files:")"
  echo "- SQL anchor files: $(anchor_value "SQL anchor files:")"
  echo "- Frontend .ts anchor files: $(anchor_value "Frontend .ts anchor files:")"
  echo "- Frontend .html anchor files: $(anchor_value "Frontend .html anchor files:")"
  echo "- Dominant module/style note: $(anchor_value "Dominant module/style note:")"
  echo "- New tables/source families/screen structure in scope: $(anchor_value "New tables/source families/screen structure in scope:")"
  echo

  echo "## Related Code References"
  echo
  echo "- Start implementation and review from the source-base anchors above."
  echo "- Compare sibling flows in the same module family before changing existing search, count, detail, update, delete, import, export, or download behavior."
  if [ -f "$FEATURE_DIR/11-implementation-report.md" ]; then
    echo "- Existing implementation evidence: \`$(relative_path "$FEATURE_DIR/11-implementation-report.md")\`"
  else
    echo "- Existing implementation evidence: \`n/a\`"
  fi
  echo

  echo "## Scope Guardrails"
  echo
  if [ -s "$README_SCOPE_SECTION" ]; then
    echo "- README scope and out-of-scope notes: \`$(relative_path "$README_FILE")\`"
    summarize_markdown "$README_SCOPE_SECTION" "$(relative_path "$README_FILE")" 8
  else
    echo "- No scope section found in \`$(relative_path "$README_FILE")\`"
  fi
  if [ -s "$DESIGN_NON_CHANGES_SECTION" ]; then
    echo "- Design non-changes: \`$(relative_path "$DESIGN_FILE")\`"
    summarize_markdown "$DESIGN_NON_CHANGES_SECTION" "$(relative_path "$DESIGN_FILE")" 6
  else
    echo "- No non-changes section found in \`$(relative_path "$DESIGN_FILE")\`"
  fi
  echo

  echo "## Traceability Snapshot"
  echo
  if [ -s "$TRACEABILITY_SECTION" ]; then
    summarize_markdown "$TRACEABILITY_SECTION" "$(relative_path "$README_FILE")" 6
  else
    echo "- No traceability section found in \`$(relative_path "$README_FILE")\`"
  fi
  echo

  for entry in \
    "Requirements Snapshot:01-requirements.md" \
    "Design Snapshot:02-design.md" \
    "Data Contract Notes:03-data-model.md" \
    "API Contract Notes:04-api-contract.md" \
    "Behavior Notes:05-behavior.md" \
    "Edge Cases:06-edge-cases.md" \
    "Task Notes:07-tasks.md" \
    "Acceptance Notes:08-acceptance-criteria.md" \
    "Test Notes:09-test-cases.md" \
    "Risk Notes:13-risk-log.md" \
    "Decision Notes:14-decision-notes.md"
  do
    section_title=${entry%%:*}
    section_file=${entry#*:}
    if [ -f "$FEATURE_DIR/$section_file" ]; then
      echo "## $section_title"
      echo
      summarize_markdown "$FEATURE_DIR/$section_file" "$(relative_path "$FEATURE_DIR/$section_file")" 8
      echo
    fi
  done

  echo "## Locked Contracts"
  echo
  contracts_file="$TMP_DIR/contracts.list"
  contract_count=0
  list_values contracts > "$contracts_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    resolved=$(resolve_path "$item")
    echo "- \`$(relative_path "$resolved")\`"
    contract_count=$((contract_count + 1))
  done < "$contracts_file"
  if [ "$contract_count" -eq 0 ]; then
    if [ -f "$FEATURE_DIR/04-api-contract.md" ]; then
      echo "- \`$(relative_path "$FEATURE_DIR/04-api-contract.md")\` remains the locked prose contract source."
    else
      echo "- No machine-readable contracts declared"
    fi
    if [ -f "$FEATURE_DIR/03-data-model.md" ]; then
      echo "- \`$(relative_path "$FEATURE_DIR/03-data-model.md")\` remains the locked durable-data source."
    fi
  fi
  echo

  echo "## Assumptions"
  echo
  assumption_file="$TMP_DIR/assumptions.list"
  assumption_count=0
  list_values assumptions > "$assumption_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    echo "- $item"
    assumption_count=$((assumption_count + 1))
  done < "$assumption_file"
  if [ "$assumption_count" -eq 0 ]; then
    echo "- None declared"
  fi
  echo

  echo "## Open Questions"
  echo
  if [ -s "$README_OPEN_QUESTIONS_SECTION" ]; then
    summarize_markdown "$README_OPEN_QUESTIONS_SECTION" "$(relative_path "$README_FILE")" 8
  else
    echo "- None recorded"
  fi
  echo

  echo "## Legacy Bridge References"
  echo
  legacy_file="$TMP_DIR/legacy.list"
  legacy_count=0
  list_values legacy_refs > "$legacy_file"
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    echo "- \`$item\`"
    legacy_count=$((legacy_count + 1))
  done < "$legacy_file"
  if [ "$legacy_count" -eq 0 ]; then
    echo "- None"
  fi
  echo

  echo "## Implementation Constraints"
  echo
  echo "- Treat the feature package as authoritative if the generated pack and prose spec ever differ."
  echo "- Do not invent missing behavior, schema rules, error handling, or rollout logic."
  echo "- Use contracts for wire or data shape; use specs for scope, intent, rollout, and traceability."
  echo "- Preserve the dominant local module pattern instead of creating a new family by convenience."
  echo "- Load \`agent/\` only when canonical docs do not already answer the task."
  echo "- Identify and follow source-base anchors in the touched module family before editing backend, SQL, or frontend files."
  echo "- Keep SQL and Angular HTML formatting aligned with the named anchor files; do not reformat to a new style."
  echo "- Do not introduce new table definitions, new source families, or new screen structure unless the governing spec explicitly marks them in scope."
  echo "- Keep implementation within the documented in-scope, out-of-scope, and non-change boundaries."
  echo "- Stop and record conflicts or missing artifacts instead of guessing through them."
} > "$OUTPUT_PATH"

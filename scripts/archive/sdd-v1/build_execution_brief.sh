#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM
CANONICAL_SPECS_DIR="$ROOT_DIR/docs/specs"
SUPPORT_EXAMPLES_DIR="$ROOT_DIR/docs/specs-support/examples"
SUPPORT_FIXTURES_DIR="$ROOT_DIR/docs/specs-support/fixtures"

TASK_PROFILE="implement-new"
SPEC_PACK_INPUT="auto"
BACKEND_SPEC="n/a"
BUG_SOURCE="n/a"
REVIEW_SCOPE="n/a"
OUTPUT_PATH=""

usage() {
  cat >&2 <<'EOF'
Usage: sh scripts/sdd/build_execution_brief.sh <feature-id-or-path> [options]

Options:
  --task-profile <implement-new|fix-from-pack|fix-from-bug|review-from-pack|review-from-rules>
  --spec-pack <path|auto|n/a>
  --backend-spec <path|alias:backend-spec|n/a>
  --bug-source <path|text|n/a>
  --review-scope <spec|rules|spec+rules|n/a>
  --output <path>

Examples:
  sh scripts/sdd/build_execution_brief.sh 2026-03-11-example-customer-export
  sh scripts/sdd/build_execution_brief.sh docs/specs-support/examples/2026-03-11-example-customer-export --task-profile review-from-pack --spec-pack auto
EOF
  exit 1
}

trim() {
  printf '%s' "$1" | awk '
    {
      gsub(/^[[:space:]]+/, "", $0)
      gsub(/[[:space:]]+$/, "", $0)
      print
    }
  '
}

relative_path() {
  printf '%s\n' "$1" | sed "s#^$ROOT_DIR/##"
}

normalize_value() {
  value=$(trim "${1:-}")
  if [ -n "$value" ]; then
    printf '%s\n' "$value"
  else
    printf 'unknown (not explicitly stated in source)\n'
  fi
}

scalar_front_matter() {
  file=$1
  key=$2
  awk -v key="$key" '
    BEGIN {
      front_seen = 0
      in_front = 0
    }
    {
      sub(/\r$/, "", $0)
    }
    /^---$/ {
      if (front_seen == 0) {
        in_front = 1
        front_seen = 1
        next
      }
      if (in_front == 1) {
        exit
      }
    }
    in_front == 1 && $0 ~ ("^" key ":[[:space:]]*") {
      sub("^" key ":[[:space:]]*", "", $0)
      gsub(/^"/, "", $0)
      gsub(/"$/, "", $0)
      print $0
      exit
    }
  ' "$file"
}

list_front_matter() {
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
        in_front = 1
        front_seen = 1
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

manifest_list_values() {
  section=$1
  manifest=$2
  awk -v section="$section" '
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
  ' "$manifest"
}

extract_section() {
  src=$1
  start_pattern=$2
  stop_pattern=$3
  dst=$4
  awk -v start="$start_pattern" -v stop="$stop_pattern" '
    {
      sub(/\r$/, "", $0)
    }
    $0 ~ start {
      in_section = 1
      next
    }
    in_section && $0 ~ stop {
      exit
    }
    in_section {
      print
    }
  ' "$src" > "$dst"
}

emit_list_block() {
  src=$1
  if [ ! -s "$src" ]; then
    return 1
  fi

  awk '
    BEGIN {
      printed = 0
    }
    /^[[:space:]]*$/ { next }
    /^[[:space:]]*[-*][[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]*[-*][[:space:]]+/, "", line)
      print "- " line
      printed = 1
      next
    }
    /^[[:space:]]*[0-9]+\.[[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]*[0-9]+\.[[:space:]]+/, "", line)
      print "- " line
      printed = 1
    }
    END {
      if (printed == 0) {
        exit 1
      }
    }
  ' "$src"
}

emit_path_line() {
  label=$1
  value=$2
  if [ "$value" = "n/a" ]; then
    echo "- $label: \`n/a\`"
  elif printf '%s' "$value" | grep -q '`'; then
    echo "- $label: $value"
  else
    echo "- $label: \`$value\`"
  fi
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

emit_design_decisions() {
  decisions_section="$TMP_DIR/design-decisions.md"
  extract_section "$DESIGN_FILE" "^## Design Decisions$" "^## " "$decisions_section"

  if awk '
      BEGIN { found = 0 }
      /^\|/ && $0 ~ /DES-[0-9]+/ { found = 1 }
      END { exit(found ? 0 : 1) }
    ' "$decisions_section"
  then
    awk '
      /^\|/ && $0 ~ /DES-[0-9]+/ {
        line = $0
        sub(/\r$/, "", line)
        split(line, parts, "|")
        id = parts[2]
        decision = parts[3]
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", id)
        gsub(/`/, "", id)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", decision)
        if (id ~ /^DES-[0-9]+$/) {
          print "- `" id "` " decision
        }
      }
    ' "$decisions_section"
    return 0
  fi

  awk '
    BEGIN {
      current_id = ""
      decision = ""
      printed = 0
    }
    {
      sub(/\r$/, "", $0)
    }
    /^### DES-[0-9]+/ {
      if (current_id != "") {
        if (decision == "") {
          decision = "unknown (decision text not explicitly stated in source)"
        }
        print "- `" current_id "` " decision
        printed = 1
      }
      current_id = $2
      decision = ""
      next
    }
    /^- Decision:/ {
      sub(/^- Decision:[[:space:]]*/, "", $0)
      decision = $0
      next
    }
    END {
      if (current_id != "") {
        if (decision == "") {
          decision = "unknown (decision text not explicitly stated in source)"
        }
        print "- `" current_id "` " decision
        printed = 1
      }
      exit(printed == 0)
    }
  ' "$decisions_section"
}

emit_test_case_ids() {
  awk '
    /^\|/ && $0 ~ /TC-[0-9]+/ {
      line = $0
      sub(/\r$/, "", line)
      split(line, parts, "|")
      id = parts[2]
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id)
      gsub(/`/, "", id)
      if (id ~ /^TC-[0-9]+$/) {
        print id
      }
    }
  ' "$TEST_FILE"
}

joined_test_case_ids() {
  ids=$(emit_test_case_ids | paste -sd ',' -)
  ids=$(printf '%s' "$ids" | sed 's/,/, /g')
  if [ -n "$ids" ]; then
    printf '%s\n' "$ids"
  else
    printf 'unknown (no parseable TC- ids found)\n'
  fi
}

emit_read_line() {
  path=$1
  reason=$2
  echo "- \`$path\` - $reason"
}

emit_optional_line() {
  path=$1
  reason=$2
  echo "- \`$path\` - $reason"
}

append_line_if_missing() {
  file=$1
  line=$2
  if ! grep -Fqx "$line" "$file" 2>/dev/null; then
    printf '%s\n' "$line" >> "$file"
  fi
}

add_standard_references() {
  standards_file=$1
  if [ -f "$MANIFEST_FILE" ]; then
    manifest_list_values standards "$MANIFEST_FILE" > "$TMP_DIR/manifest-standards.txt" || true
    if [ -s "$TMP_DIR/manifest-standards.txt" ]; then
      cat "$TMP_DIR/manifest-standards.txt" >> "$standards_file"
    fi
  fi

  append_line_if_missing "$standards_file" "docs/sdd/standards/repository-context.md"

  if [ "$BACKEND_PROCESS_ANCHOR" != "n/a" ] || [ "$BACKEND_WEBSERVICE_ANCHOR" != "n/a" ]; then
    append_line_if_missing "$standards_file" "docs/sdd/standards/backend-process-architecture.md"
    append_line_if_missing "$standards_file" "docs/sdd/standards/backend-change-rules.md"
  fi

  if [ "$FRONTEND_TS_ANCHOR" != "n/a" ] || [ "$FRONTEND_HTML_ANCHOR" != "n/a" ] || [ -f "$FEATURE_DIR/05-behavior.md" ]; then
    append_line_if_missing "$standards_file" "docs/sdd/standards/frontend-screen-architecture.md"
    append_line_if_missing "$standards_file" "docs/sdd/standards/frontend-change-rules.md"
  fi

  if [ "$SQL_ANCHOR" != "n/a" ] || [ -f "$FEATURE_DIR/03-data-model.md" ]; then
    append_line_if_missing "$standards_file" "docs/sdd/standards/database-change-rules.md"
  fi

  if [ -f "$FEATURE_DIR/04-api-contract.md" ] || [ -d "$FEATURE_DIR/contracts" ]; then
    append_line_if_missing "$standards_file" "docs/sdd/standards/security-validation-and-logging.md"
  fi

  if grep -Riq "csv" "$FEATURE_DIR" 2>/dev/null; then
    append_line_if_missing "$standards_file" "docs/sdd/standards/module-patterns/csv.md"
  fi
}

emit_standard_lines() {
  standards_file=$1
  if [ ! -s "$standards_file" ]; then
    echo "- unknown (no selected standards could be derived)"
    return
  fi

  awk '
    NF > 0 && !seen[$0]++ {
      print "- `" $0 "` - selected repository standard for the touched layer or workflow"
    }
  ' "$standards_file"
}

resolve_feature_dir() {
  arg=$1
  case "$arg" in
    docs/specs/*|docs/specs-support/*)
      printf '%s/%s\n' "$ROOT_DIR" "$arg"
      ;;
    *)
      if [ -d "$CANONICAL_SPECS_DIR/$arg" ]; then
        printf '%s\n' "$CANONICAL_SPECS_DIR/$arg"
      elif [ -d "$SUPPORT_EXAMPLES_DIR/$arg" ]; then
        printf '%s\n' "$SUPPORT_EXAMPLES_DIR/$arg"
      elif [ -d "$SUPPORT_FIXTURES_DIR/$arg" ]; then
        printf '%s\n' "$SUPPORT_FIXTURES_DIR/$arg"
      else
        printf '%s\n' "$CANONICAL_SPECS_DIR/$arg"
      fi
      ;;
  esac
}

infer_classification() {
  if [ -f "$FEATURE_DIR/03-data-model.md" ] || [ -f "$FEATURE_DIR/04-api-contract.md" ] || [ -f "$FEATURE_DIR/05-behavior.md" ] || [ -f "$FEATURE_DIR/06-edge-cases.md" ]; then
    printf 'full-path\n'
  else
    printf 'reduced-path\n'
  fi
}

resolve_spec_pack_path() {
  detected="$ROOT_DIR/docs/spec-packs/$FEATURE_ID.pack.md"
  if [ "$SPEC_PACK_INPUT" = "auto" ]; then
    if [ -f "$detected" ]; then
      printf '%s\n' "$detected"
    else
      printf 'n/a\n'
    fi
    return
  fi

  if [ "$SPEC_PACK_INPUT" = "n/a" ]; then
    printf 'n/a\n'
    return
  fi

  if [ -f "$ROOT_DIR/$SPEC_PACK_INPUT" ]; then
    printf '%s\n' "$ROOT_DIR/$SPEC_PACK_INPUT"
    return
  fi

  if [ -f "$SPEC_PACK_INPUT" ]; then
    printf '%s\n' "$SPEC_PACK_INPUT"
    return
  fi

  printf 'unknown (requested spec-pack not found: %s)\n' "$SPEC_PACK_INPUT"
}

emit_governing_files() {
  for item in \
    "README.md" \
    "01-requirements.md" \
    "02-design.md" \
    "07-tasks.md" \
    "08-acceptance-criteria.md" \
    "09-test-cases.md" \
    "10-rollout.md" \
    "changelog.md"
  do
    if [ -f "$FEATURE_DIR/$item" ]; then
      echo "- \`$(relative_path "$FEATURE_DIR/$item")\`"
    fi
  done

  for item in \
    "03-data-model.md" \
    "04-api-contract.md" \
    "05-behavior.md" \
    "06-edge-cases.md" \
    "11-implementation-report.md" \
    "12-review-report.md" \
    "13-risk-log.md" \
    "14-decision-notes.md"
  do
    if [ -f "$FEATURE_DIR/$item" ]; then
      echo "- \`$(relative_path "$FEATURE_DIR/$item")\`"
    fi
  done
}

emit_base_mandatory_reads() {
  emit_read_line "AGENTS.md" "root execution contract"
  emit_read_line "docs/sdd/context/constitution.md" "non-negotiable SDD rules"
  emit_read_line "docs/sdd/context/note.md" "repository-specific pitfalls and cautions"
  emit_read_line "docs/sdd/context/architecture-context.md" "repository shape and module families"
  emit_read_line "docs/sdd/context/product-context.md" "business-domain and system-change context"
  emit_read_line "docs/sdd/context/tech-context.md" "stack and implementation constraints"
  emit_read_line "docs/sdd/context/ai-loading-order.md" "canonical loading order"
  emit_read_line "docs/sdd/context/task-profiles.md" "task-profile routing matrix"
  emit_read_line "docs/sdd/governance.md" "change classification and gate rules"
  emit_read_line "docs/specs/README.md" "feature-package rules and required files"
}

emit_feature_mandatory_reads() {
  emit_read_line "$(relative_path "$README_FILE")" "feature summary, traceability, and artifact status"
  emit_read_line "$(relative_path "$REQ_FILE")" "requirements and scope constraints"
  emit_read_line "$(relative_path "$DESIGN_FILE")" "design intent, anchors, and locked decisions"
  emit_read_line "$(relative_path "$TASK_FILE")" "implementation task breakdown"
  emit_read_line "$(relative_path "$AC_FILE")" "acceptance conditions"
  emit_read_line "$(relative_path "$TEST_FILE")" "verification targets"

  for item in "03-data-model.md" "04-api-contract.md" "05-behavior.md" "06-edge-cases.md"; do
    if [ -f "$FEATURE_DIR/$item" ]; then
      emit_read_line "$(relative_path "$FEATURE_DIR/$item")" "feature-owned conditional artifact"
    fi
  done

  for item in "13-risk-log.md" "14-decision-notes.md"; do
    if [ -f "$FEATURE_DIR/$item" ]; then
      emit_read_line "$(relative_path "$FEATURE_DIR/$item")" "feature-owned SDD2+ companion artifact"
    fi
  done

  if [ -d "$FEATURE_DIR/contracts" ]; then
    emit_read_line "$(relative_path "$FEATURE_DIR/contracts")/" "machine-readable contract source"
  fi
}

emit_profile_specific_reads() {
  case "$TASK_PROFILE" in
    implement-new)
      :
      ;;
    fix-from-pack)
      if [ "$SPEC_PACK_PATH" = "n/a" ]; then
        echo "- unknown (task profile requires a generated spec-pack but none was found)"
      else
        emit_read_line "$(relative_path "$SPEC_PACK_PATH")" "generated execution aid required by the selected task profile"
      fi
      ;;
    fix-from-bug)
      if [ "$BUG_SOURCE" = "n/a" ]; then
        echo "- unknown (task profile expects a bug source input)"
      elif [ -f "$ROOT_DIR/$BUG_SOURCE" ]; then
        emit_read_line "$BUG_SOURCE" "bug source provided to drive the fix"
      elif [ -f "$BUG_SOURCE" ]; then
        emit_read_line "$(relative_path "$BUG_SOURCE")" "bug source provided to drive the fix"
      else
        echo "- \`bug-source\` - $BUG_SOURCE"
      fi
      ;;
    review-from-pack)
      if [ -f "$FEATURE_DIR/11-implementation-report.md" ]; then
        emit_read_line "$(relative_path "$FEATURE_DIR/11-implementation-report.md")" "implementation evidence for review"
      fi
      if [ -f "$FEATURE_DIR/12-review-report.md" ]; then
        emit_read_line "$(relative_path "$FEATURE_DIR/12-review-report.md")" "existing review context"
      fi
      if [ "$SPEC_PACK_PATH" = "n/a" ]; then
        echo "- unknown (task profile requires a generated spec-pack but none was found)"
      else
        emit_read_line "$(relative_path "$SPEC_PACK_PATH")" "generated execution aid required by the selected task profile"
      fi
      emit_read_line "docs/sdd/checklists/06-code-review-against-spec.md" "review checklist for governed code review"
      ;;
    review-from-rules)
      if [ -f "$FEATURE_DIR/11-implementation-report.md" ]; then
        emit_read_line "$(relative_path "$FEATURE_DIR/11-implementation-report.md")" "implementation evidence for rule-based review"
      fi
      emit_read_line "docs/sdd/checklists/06-code-review-against-spec.md" "review checklist for governed code review"
      emit_read_line "docs/sdd/checklists/07-qa-validation.md" "QA validation checklist when verification scope matters"
      ;;
    *)
      echo "- unknown (unsupported task profile: $TASK_PROFILE)"
      ;;
  esac
}

emit_optional_consults() {
  printed=0
  if [ "$TASK_PROFILE" != "fix-from-pack" ] && [ "$TASK_PROFILE" != "review-from-pack" ] && [ "$SPEC_PACK_PATH" != "n/a" ]; then
    emit_optional_line "$(relative_path "$SPEC_PACK_PATH")" "generated execution aid; feature package still wins on conflicts"
    printed=1
  fi

  if [ -f "$FEATURE_DIR/11-implementation-report.md" ] && [ "$TASK_PROFILE" != "review-from-pack" ] && [ "$TASK_PROFILE" != "review-from-rules" ]; then
    emit_optional_line "$(relative_path "$FEATURE_DIR/11-implementation-report.md")" "implementation evidence when delivered behavior matters"
    printed=1
  fi

  if [ -f "$FEATURE_DIR/12-review-report.md" ] && [ "$TASK_PROFILE" != "review-from-pack" ]; then
    emit_optional_line "$(relative_path "$FEATURE_DIR/12-review-report.md")" "existing review verdict and findings"
    printed=1
  fi

  if [ "$BACKEND_SPEC" = "alias:backend-spec" ]; then
    emit_optional_line "$(relative_path "$DESIGN_FILE")" "backend alias expands to backend-facing canonical design"
    printed=1
    if [ -f "$FEATURE_DIR/03-data-model.md" ]; then
      emit_optional_line "$(relative_path "$FEATURE_DIR/03-data-model.md")" "backend alias includes data-model context when owned"
      printed=1
    fi
    if [ -f "$FEATURE_DIR/04-api-contract.md" ]; then
      emit_optional_line "$(relative_path "$FEATURE_DIR/04-api-contract.md")" "backend alias includes API contract context when owned"
      printed=1
    fi
    if [ -f "$FEATURE_DIR/06-edge-cases.md" ]; then
      emit_optional_line "$(relative_path "$FEATURE_DIR/06-edge-cases.md")" "backend alias includes backend-relevant failure paths"
      printed=1
    fi
  elif [ "$BACKEND_SPEC" != "n/a" ]; then
    if [ -f "$ROOT_DIR/$BACKEND_SPEC" ]; then
      emit_optional_line "$BACKEND_SPEC" "helper-only backend input"
      printed=1
    elif [ -f "$BACKEND_SPEC" ]; then
      emit_optional_line "$(relative_path "$BACKEND_SPEC")" "helper-only backend input"
      printed=1
    else
      echo "- \`backend-spec\` - unknown (requested backend helper not found: $BACKEND_SPEC)"
      printed=1
    fi
  fi

  adr_refs="$TMP_DIR/adr-refs.txt"
  list_front_matter "$README_FILE" dependencies | awk '/^docs\/decisions\// { print }' > "$adr_refs" || true
  if [ -s "$adr_refs" ]; then
    while IFS= read -r adr; do
      [ -n "$adr" ] || continue
      emit_optional_line "$adr" "ADR linked from the governing feature package"
      printed=1
    done < "$adr_refs"
  fi

  if [ "$printed" -eq 0 ]; then
    echo "- \`n/a\` - no optional helper inputs were derived for this request"
  fi
}

emit_expected_outputs() {
  case "$TASK_PROFILE" in
    implement-new)
      echo "- Deliver implementation and verification aligned to the governing \`REQ -> DES -> TASK -> AC -> TC\` chain."
      ;;
    fix-from-pack)
      echo "- Deliver the code fix and update canonical spec artifacts when approved behavior, design, or tests changed."
      ;;
    fix-from-bug)
      echo "- Deliver the code fix and keep the governing feature package current enough to explain approved scope and verification."
      ;;
    review-from-pack)
      echo "- Deliver review findings and verdict tied to the governing feature package, using the generated pack only as acceleration aid."
      ;;
    review-from-rules)
      echo "- Deliver rule-based review findings, risks, and verdict with correct source attribution back to the governed feature package."
      ;;
  esac

  if [ -d "$FEATURE_DIR/contracts" ]; then
    echo "- Keep \`04-api-contract.md\` and \`contracts/\` aligned if interface or durable data shape changes."
  fi

  if [ -f "$MANIFEST_FILE" ]; then
    echo "- Rebuild the generated spec-pack if the feature keeps \`spec-pack.manifest.yaml\`."
  fi

  echo "- Update \`10-rollout.md\` and \`changelog.md\` when behavior or release guidance changes."

  if [ "$TASK_PROFILE" = "implement-new" ] || [ "$TASK_PROFILE" = "fix-from-pack" ] || [ "$TASK_PROFILE" = "fix-from-bug" ]; then
    echo "- Record delivered implementation in \`11-implementation-report.md\` once implementation starts."
  fi

  if [ "$TASK_PROFILE" = "review-from-pack" ] || [ "$TASK_PROFILE" = "review-from-rules" ] || [ -f "$FEATURE_DIR/12-review-report.md" ]; then
    echo "- Record review findings and verdict in \`12-review-report.md\` when formal review starts."
  fi
  if [ -f "$FEATURE_DIR/13-risk-log.md" ]; then
    echo "- Keep \`13-risk-log.md\` aligned with current mitigations, open risks, and release blockers."
  fi
  if [ -f "$FEATURE_DIR/14-decision-notes.md" ]; then
    echo "- Keep \`14-decision-notes.md\` aligned with local feature decisions and ADR links."
  fi
}

[ $# -ge 1 ] || usage

FEATURE_ARG=$1
shift

while [ $# -gt 0 ]; do
  case "$1" in
    --task-profile)
      [ $# -ge 2 ] || usage
      TASK_PROFILE=$2
      shift 2
      ;;
    --spec-pack)
      [ $# -ge 2 ] || usage
      SPEC_PACK_INPUT=$2
      shift 2
      ;;
    --backend-spec)
      [ $# -ge 2 ] || usage
      BACKEND_SPEC=$2
      shift 2
      ;;
    --bug-source)
      [ $# -ge 2 ] || usage
      BUG_SOURCE=$2
      shift 2
      ;;
    --review-scope)
      [ $# -ge 2 ] || usage
      REVIEW_SCOPE=$2
      shift 2
      ;;
    --output)
      [ $# -ge 2 ] || usage
      OUTPUT_PATH=$2
      shift 2
      ;;
    *)
      usage
      ;;
  esac
done

case "$TASK_PROFILE" in
  implement-new|fix-from-pack|fix-from-bug|review-from-pack|review-from-rules)
    ;;
  *)
    echo "Unsupported task profile: $TASK_PROFILE" >&2
    exit 1
    ;;
esac

FEATURE_DIR=$(resolve_feature_dir "$FEATURE_ARG")
[ -d "$FEATURE_DIR" ] || {
  echo "Feature package not found: $FEATURE_DIR" >&2
  exit 1
}

README_FILE="$FEATURE_DIR/README.md"
REQ_FILE="$FEATURE_DIR/01-requirements.md"
DESIGN_FILE="$FEATURE_DIR/02-design.md"
TASK_FILE="$FEATURE_DIR/07-tasks.md"
AC_FILE="$FEATURE_DIR/08-acceptance-criteria.md"
TEST_FILE="$FEATURE_DIR/09-test-cases.md"
ROLLOUT_FILE="$FEATURE_DIR/10-rollout.md"
CHANGELOG_FILE="$FEATURE_DIR/changelog.md"
MANIFEST_FILE="$FEATURE_DIR/spec-pack.manifest.yaml"

for required_file in "$README_FILE" "$REQ_FILE" "$DESIGN_FILE" "$TASK_FILE" "$AC_FILE" "$TEST_FILE" "$ROLLOUT_FILE" "$CHANGELOG_FILE"; do
  [ -f "$required_file" ] || {
    echo "Missing required feature artifact: $(relative_path "$required_file")" >&2
    exit 1
  }
done

FEATURE_ID=$(scalar_front_matter "$README_FILE" id)
FEATURE_TITLE=$(scalar_front_matter "$README_FILE" title)
FEATURE_STATUS=$(scalar_front_matter "$README_FILE" status)
[ -n "$FEATURE_ID" ] || FEATURE_ID=$(basename "$FEATURE_DIR")
CLASSIFICATION=$(infer_classification)
SPEC_PACK_PATH=$(resolve_spec_pack_path)

BACKEND_PROCESS_ANCHOR=$(normalize_value "$(anchor_value 'Backend process anchor files:')")
BACKEND_WEBSERVICE_ANCHOR=$(normalize_value "$(anchor_value 'Backend webservice anchor files:')")
SQL_ANCHOR=$(normalize_value "$(anchor_value 'SQL anchor files:')")
FRONTEND_TS_ANCHOR=$(normalize_value "$(anchor_value 'Frontend .ts anchor files:')")
FRONTEND_HTML_ANCHOR=$(normalize_value "$(anchor_value 'Frontend .html anchor files:')")
STYLE_NOTE=$(normalize_value "$(anchor_value 'Dominant module/style note:')")
STRUCTURE_SCOPE=$(normalize_value "$(anchor_value 'New tables/source families/screen structure in scope:')")

if [ -z "$OUTPUT_PATH" ]; then
  OUTPUT_PATH="$ROOT_DIR/docs/spec-packs/$FEATURE_ID.$TASK_PROFILE.brief.md"
fi

case "$OUTPUT_PATH" in
  /*|[A-Za-z]:/*)
    FINAL_OUTPUT="$OUTPUT_PATH"
    ;;
  *)
    FINAL_OUTPUT="$ROOT_DIR/$OUTPUT_PATH"
    ;;
esac

mkdir -p "$(dirname "$FINAL_OUTPUT")"

IN_SCOPE_FILE="$TMP_DIR/in-scope.md"
OUT_SCOPE_FILE="$TMP_DIR/out-of-scope.md"
NON_CHANGES_FILE="$TMP_DIR/non-changes.md"
STANDARDS_FILE="$TMP_DIR/standards.txt"
> "$STANDARDS_FILE"

extract_section "$README_FILE" "^### In Scope$" "^### |^## " "$IN_SCOPE_FILE"
extract_section "$README_FILE" "^### Out Of Scope$" "^### |^## " "$OUT_SCOPE_FILE"
extract_section "$DESIGN_FILE" "^## Non-Changes$" "^## " "$NON_CHANGES_FILE"
OPEN_QUESTIONS_FILE="$TMP_DIR/open-questions.md"
extract_section "$README_FILE" "^## Open Questions$" "^## " "$OPEN_QUESTIONS_FILE"
add_standard_references "$STANDARDS_FILE"

{
  echo "---"
  echo "brief_version: 1"
  echo "feature: \"$FEATURE_ID\""
  echo "task_profile: \"$TASK_PROFILE\""
  echo "governance_classification: \"$CLASSIFICATION\""
  echo "feature_status: \"$(normalize_value "$FEATURE_STATUS")\""
  echo "review_scope: \"$REVIEW_SCOPE\""
  if [ "$SPEC_PACK_PATH" = "n/a" ]; then
    echo "spec_pack: \"n/a\""
  elif [ -f "$SPEC_PACK_PATH" ]; then
    echo "spec_pack: \"$(relative_path "$SPEC_PACK_PATH")\""
  else
    echo "spec_pack: \"$SPEC_PACK_PATH\""
  fi
  echo "backend_spec: \"$BACKEND_SPEC\""
  echo "bug_source: \"$BUG_SOURCE\""
  echo "generator: \"scripts/sdd/build_execution_brief.sh\""
  echo "---"
  echo
  echo "# Execution Brief"
  echo
  echo "## Snapshot"
  echo
  echo "- Feature: \`$FEATURE_ID\`"
  echo "- Title: \`$(normalize_value "$FEATURE_TITLE")\`"
  echo "- Task profile: \`$TASK_PROFILE\`"
  echo "- Governance classification: \`$CLASSIFICATION\`"
  echo "- Feature status: \`$(normalize_value "$FEATURE_STATUS")\`"
  echo "- Governing package: \`$(relative_path "$FEATURE_DIR")/\`"
  echo "- Conflict rule: the governing feature package wins over generated execution aids"
  echo
  echo "## Required Inputs"
  echo
  echo "- Feature: \`$(relative_path "$FEATURE_DIR")/\`"
  echo "- Task Profile: \`$TASK_PROFILE\`"
  if [ "$SPEC_PACK_PATH" = "n/a" ]; then
    echo "- Spec Pack: \`n/a\`"
  elif [ -f "$SPEC_PACK_PATH" ]; then
    echo "- Spec Pack: \`$(relative_path "$SPEC_PACK_PATH")\`"
  else
    echo "- Spec Pack: \`$SPEC_PACK_PATH\`"
  fi
  echo "- Backend Spec: \`$BACKEND_SPEC\`"
  echo "- Bug Source: \`$BUG_SOURCE\`"
  echo "- Review Scope: \`$REVIEW_SCOPE\`"
  echo
  echo "## Source Of Truth Files"
  echo
  emit_governing_files
  echo
  echo "## Mandatory Reads"
  echo
  emit_base_mandatory_reads
  emit_standard_lines "$STANDARDS_FILE"
  emit_feature_mandatory_reads
  emit_profile_specific_reads
  echo
  echo "## Optional Consult"
  echo
  emit_optional_consults
  echo
  echo "## Locked Decisions"
  echo
  if ! emit_design_decisions; then
    echo "- unknown (no parseable design decisions found in \`02-design.md\`)"
  fi
  echo "- Source-base anchors are locked to the files named below:"
  emit_path_line "Backend process anchor files" "$BACKEND_PROCESS_ANCHOR"
  emit_path_line "Backend webservice anchor files" "$BACKEND_WEBSERVICE_ANCHOR"
  emit_path_line "SQL anchor files" "$SQL_ANCHOR"
  emit_path_line "Frontend .ts anchor files" "$FRONTEND_TS_ANCHOR"
  emit_path_line "Frontend .html anchor files" "$FRONTEND_HTML_ANCHOR"
  echo "- Dominant module/style note: $STYLE_NOTE"
  echo "- New tables/source families/screen structure in scope: $STRUCTURE_SCOPE"
  echo
  echo "## Prohibited Scope"
  echo
  if ! emit_list_block "$OUT_SCOPE_FILE"; then
    echo "- unknown (README.md does not state an explicit Out Of Scope list)"
  fi
  if ! emit_list_block "$NON_CHANGES_FILE"; then
    echo "- unknown (02-design.md does not state explicit non-changes)"
  fi
  echo
  echo "## Constraints"
  echo
  echo "- Read before write: inspect the named anchors, sibling flows, existing tests, and owned contracts before editing."
  echo "- Reuse before create: extend the current module family before introducing new routes, DTOs, classes, modules, or tables."
  echo "- Conflict reporting: record spec, code, test, schema, and standard conflicts instead of silently guessing through them."
  echo "- Locked contracts remain unchanged unless the governing feature package explicitly authorizes the change."
  echo "- Unknown source detail must stay \`unknown (...)\` or blocked; do not infer hidden requirements from the prompt."
  echo
  echo "## Touched Layers And Components"
  echo
  emit_path_line "Backend process" "$BACKEND_PROCESS_ANCHOR"
  emit_path_line "Backend webservice" "$BACKEND_WEBSERVICE_ANCHOR"
  emit_path_line "SQL" "$SQL_ANCHOR"
  emit_path_line "Frontend .ts" "$FRONTEND_TS_ANCHOR"
  emit_path_line "Frontend .html" "$FRONTEND_HTML_ANCHOR"
  if [ -d "$FEATURE_DIR/contracts" ]; then
    echo "- Contracts: \`$(relative_path "$FEATURE_DIR/contracts")/\`"
  else
    echo "- Contracts: \`n/a\`"
  fi
  echo
  echo "## Locked Contracts"
  echo
  if [ -d "$FEATURE_DIR/contracts" ]; then
    echo "- \`$(relative_path "$FEATURE_DIR/contracts")/\`"
  elif [ -f "$FEATURE_DIR/04-api-contract.md" ]; then
    echo "- \`$(relative_path "$FEATURE_DIR/04-api-contract.md")\` remains the locked prose contract source."
  else
    echo "- \`n/a\`"
  fi
  if [ -f "$FEATURE_DIR/03-data-model.md" ]; then
    echo "- \`$(relative_path "$FEATURE_DIR/03-data-model.md")\` remains the locked durable-data source when schema ownership is prose-only."
  fi
  echo
  echo "## Task Scope"
  echo
  if ! emit_list_block "$IN_SCOPE_FILE"; then
    echo "- unknown (README.md does not state an explicit In Scope list)"
  fi
  echo
  echo "## Done Criteria"
  echo
  echo "- \`sh scripts/sdd/validate_specs.sh $FEATURE_ID\`"
  if [ -f "$MANIFEST_FILE" ]; then
    echo "- \`sh scripts/sdd/build_spec_pack.sh $FEATURE_ID\`"
  fi
  echo "- Satisfy verification evidence for: \`$(joined_test_case_ids)\`"
  case "$TASK_PROFILE" in
    implement-new|fix-from-pack|fix-from-bug)
      echo "- Apply \`docs/sdd/checklists/04-pre-implementation-gate.md\` before implementation starts"
      ;;
  esac
  case "$TASK_PROFILE" in
    review-from-pack|review-from-rules)
      echo "- Apply \`docs/sdd/checklists/06-code-review-against-spec.md\` during formal review"
      ;;
  esac
  if [ "$TASK_PROFILE" = "implement-new" ] || [ "$TASK_PROFILE" = "fix-from-pack" ] || [ "$TASK_PROFILE" = "fix-from-bug" ]; then
    echo "- Update \`11-implementation-report.md\` with approved artifacts used, inspected code refs, reuse decisions, conflicts, and tests."
  fi
  if [ "$TASK_PROFILE" = "review-from-pack" ] || [ "$TASK_PROFILE" = "review-from-rules" ] || [ -f "$FEATURE_DIR/12-review-report.md" ]; then
    echo "- Update \`12-review-report.md\` with observed facts, grounded risks, unsupported assumptions, and confirmed hallucination findings."
  fi
  echo "- Apply \`docs/sdd/governance/definition-of-done.md\` before marking the feature done"
  echo "- Apply \`docs/sdd/governance/06-release-readiness-rules.md\` when the change is marked release-ready or merged for shipment"
  echo
  echo "## Expected Outputs"
  echo
  emit_expected_outputs
  echo
  echo "## Assumptions And Current Limits"
  echo
  echo "- This brief is generated from canonical markdown and fixed task-profile mappings; it is an execution aid, not an approval artifact."
  echo "- Classification is inferred from owned feature files: \`03-data-model.md\`, \`04-api-contract.md\`, \`05-behavior.md\`, and \`06-edge-cases.md\` imply \`full-path\`; otherwise the generator emits \`reduced-path\`."
  echo "- The generator does not infer intent from free-form prompts. Request-scoped inputs such as \`--bug-source\`, \`--backend-spec\`, \`--review-scope\`, and \`--spec-pack\` must be provided explicitly when needed."
  echo "- Missing scope, decision, or helper inputs are emitted as \`unknown (...)\` rather than guessed."
  echo
  echo "## Open Questions"
  echo
  if ! emit_list_block "$OPEN_QUESTIONS_FILE"; then
    echo "- None recorded"
  fi
} > "$FINAL_OUTPUT"

echo "Execution brief generated: $(relative_path "$FINAL_OUTPUT")"

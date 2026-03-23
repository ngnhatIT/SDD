#!/bin/sh

set -eu

SCRIPT_ROOT=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
ROOT_DIR=$SCRIPT_ROOT
ISSUE_FILE=$(mktemp)
ERROR_MARKER=$(mktemp)
trap 'rm -f "$ISSUE_FILE" "$ERROR_MARKER"' EXIT HUP INT TERM

usage() {
  cat >&2 <<'EOF'
Usage: sh scripts/sdd/validate_framework_docs.sh [--root <path>]

Validates canonical framework navigation, helper discoverability, and bridge pointers.
EOF
  exit 1
}

uppercase() {
  printf '%s' "$1" | tr '[:lower:]' '[:upper:]'
}

add_issue() {
  level=$1
  severity=$2
  message=$3
  source=$4
  why=$5
  next=$6

  printf '[%s][%s] %s\n' "$(uppercase "$level")" "$(uppercase "$severity")" "$message" >> "$ISSUE_FILE"
  printf '  Rule source: %s\n' "$source" >> "$ISSUE_FILE"
  printf '  Why: %s\n' "$why" >> "$ISSUE_FILE"
  printf '  Next action: %s\n' "$next" >> "$ISSUE_FILE"

  if [ "$level" = "error" ]; then
    printf '1\n' >> "$ERROR_MARKER"
  fi
}

add_error() {
  add_issue error "${5:-high}" "$1" "$2" "$3" "$4"
}

add_warning() {
  add_issue warning "${5:-medium}" "$1" "$2" "$3" "$4"
}

resolve_path() {
  printf '%s\n' "$ROOT_DIR/$1"
}

require_file() {
  rel_path=$1
  source=$2
  why=$3
  next=$4

  if [ ! -f "$(resolve_path "$rel_path")" ]; then
    add_error "$rel_path: missing required framework file" "$source" "$why" "$next"
  fi
}

require_contains() {
  rel_path=$1
  pattern=$2
  message=$3
  source=$4
  why=$5
  next=$6
  level=${7:-error}
  severity=${8:-high}
  file_path=$(resolve_path "$rel_path")

  [ -f "$file_path" ] || return 0

  if grep -Eq "$pattern" "$file_path"; then
    return 0
  fi

  if [ "$level" = "warning" ]; then
    add_warning "$rel_path: $message" "$source" "$why" "$next" "$severity"
  else
    add_error "$rel_path: $message" "$source" "$why" "$next" "$severity"
  fi
}

validate_docs_readme() {
  rel_path=docs/README.md
  source="docs/README.md; docs/sdd/README.md"
  why="the documentation home page should route operators to the canonical framework entrypoints instead of leaving discovery implicit."

  require_file "$rel_path" "$source" "$why" "restore docs/README.md and its canonical routing table"
  require_contains "$rel_path" 'sdd/README\.md' "missing canonical pointer to docs/sdd/README.md" "$source" "$why" "add the sdd/README.md entry back to docs/README.md"
  require_contains "$rel_path" 'sdd/governance/minimal-sufficient-context-policy\.md' "missing canonical pointer to the minimal-sufficient-context policy" "$source" "$why" "add the minimal-sufficient-context-policy.md entry back to docs/README.md"
  require_contains "$rel_path" 'sdd/prompts/daily-operator-guide\.md' "missing canonical pointer to the daily operator guide" "$source" "$why" "add the daily-operator-guide.md entry back to docs/README.md"
  require_contains "$rel_path" 'sdd/ai-ops/framework-health-metrics\.md' "missing canonical pointer to framework health metrics" "$source" "$why" "add the framework-health-metrics.md entry back to docs/README.md"
  require_contains "$rel_path" 'sdd/ai-ops/framework-self-audit\.md' "missing canonical pointer to framework self-audit guidance" "$source" "$why" "add the framework-self-audit.md entry back to docs/README.md"
  require_contains "$rel_path" 'specs/README\.md' "missing canonical pointer to docs/specs/README.md" "$source" "$why" "add the specs/README.md entry back to docs/README.md"
}

validate_sdd_readme() {
  rel_path=docs/sdd/README.md
  source="docs/sdd/README.md; AGENTS.md"
  why="the SDD playbook should surface canonical framework routing, helper-only ai-ops surfaces, and retained bridge handling explicitly."

  require_file "$rel_path" "$source" "$why" "restore docs/sdd/README.md"
  require_contains "$rel_path" 'ai-ops/framework-self-audit\.md' "missing discoverability link to framework-self-audit.md" "$source" "$why" "add a framework-self-audit.md reference to docs/sdd/README.md"
  require_contains "$rel_path" 'agent/' "missing retained bridge reference for the agent/ compatibility surface" "$source" "$why" "restore the retained bridge wording for agent/ in docs/sdd/README.md"
  require_contains "$rel_path" 'bridge|legacy|helper-only|compatibility' "mentions framework surfaces without explicit bridge/helper wording" "$source" "$why" "clarify bridge/helper wording in docs/sdd/README.md" warning low
}

validate_ai_ops_readme() {
  rel_path=docs/sdd/ai-ops/README.md
  source="docs/sdd/ai-ops/README.md; docs/sdd/README.md"
  why="ai-ops is helper-only, so its README should expose the current helper documents without becoming a second policy hub."

  require_file "$rel_path" "$source" "$why" "restore docs/sdd/ai-ops/README.md"
  require_contains "$rel_path" 'framework-health-metrics\.md' "missing framework-health-metrics.md pointer" "$source" "$why" "add the framework-health-metrics.md pointer back to ai-ops/README.md"
  require_contains "$rel_path" 'framework-self-audit\.md' "missing framework-self-audit.md pointer" "$source" "$why" "add the framework-self-audit.md pointer back to ai-ops/README.md"
  require_contains "$rel_path" 'helper|helper-only' "missing helper-only wording" "$source" "$why" "clarify that ai-ops is helper-only in ai-ops/README.md" warning low
}

validate_bridge_docs() {
  [ -d "$(resolve_path agent)" ] || return 0

  source="AGENTS.md; docs/sdd/README.md"
  why="retained bridge roots must point operators back to canonical docs and must identify themselves as bridge or compatibility material."

  require_file "agent/START_HERE.md" "$source" "$why" "restore agent/START_HERE.md as a bridge landing page"
  require_file "agent/PROMPTS.md" "$source" "$why" "restore agent/PROMPTS.md as a bridge landing page"
  require_file "agent/pipeline/README.md" "$source" "$why" "restore agent/pipeline/README.md as a bridge landing page"
  require_file "agent/standards/README.md" "$source" "$why" "restore agent/standards/README.md as a bridge landing page"
  require_file "agent/checklists/README.md" "$source" "$why" "restore agent/checklists/README.md as a bridge landing page"
  require_file "agent/spec-pack/README.md" "$source" "$why" "restore agent/spec-pack/README.md as a bridge landing page"

  for rel_path in \
    agent/START_HERE.md \
    agent/PROMPTS.md \
    agent/pipeline/README.md \
    agent/standards/README.md \
    agent/checklists/README.md \
    agent/spec-pack/README.md
  do
    require_contains "$rel_path" 'Legacy|legacy|bridge|Bridge|compatibility|Compatibility' "missing bridge or compatibility wording" "$source" "$why" "label the bridge doc clearly as legacy, bridge, or compatibility material"
    require_contains "$rel_path" 'AGENTS\.md|docs/sdd/|docs/specs/README\.md|docs/spec-packs/' "missing canonical pointer back to live framework docs" "$source" "$why" "add canonical pointers back to AGENTS.md, docs/sdd/, or docs/specs/README.md"
  done

  require_contains "agent/START_HERE.md" '\.\./AGENTS\.md' "missing pointer to ../AGENTS.md" "$source" "$why" "restore the pointer to ../AGENTS.md in agent/START_HERE.md"
  require_contains "agent/START_HERE.md" '\.\./docs/sdd/README\.md' "missing pointer to ../docs/sdd/README.md" "$source" "$why" "restore the pointer to ../docs/sdd/README.md in agent/START_HERE.md"
  require_contains "agent/START_HERE.md" '\.\./docs/specs/README\.md' "missing pointer to ../docs/specs/README.md" "$source" "$why" "restore the pointer to ../docs/specs/README.md in agent/START_HERE.md"
}

validate_canonical_bridge_wording() {
  source="AGENTS.md; docs/sdd/README.md; docs/sdd/context/note.md"
  why="active canonical docs should not mention retained bridge roots ambiguously."

  for rel_path in AGENTS.md docs/sdd/README.md docs/sdd/context/ai-loading-order.md docs/sdd/context/note.md docs/sdd/context/repo-structure-schema.md; do
    file_path=$(resolve_path "$rel_path")
    [ -f "$file_path" ] || continue

    if grep -q 'agent/' "$file_path" && ! grep -Eiq 'bridge|legacy|historical|helper|compatibility' "$file_path"; then
      add_warning \
        "$rel_path: mentions agent/ without explicit bridge wording" \
        "$source" \
        "$why" \
        "clarify the agent/ reference as bridge-only, legacy, historical, helper-only, or compatibility material" \
        "low"
    fi
  done
}

while [ $# -gt 0 ]; do
  case "$1" in
    --root)
      [ $# -ge 2 ] || usage
      ROOT_DIR=$2
      shift 2
      ;;
    *)
      usage
      ;;
  esac
done

validate_docs_readme
validate_sdd_readme
validate_ai_ops_readme
validate_bridge_docs
validate_canonical_bridge_wording

if [ -s "$ISSUE_FILE" ]; then
  if [ -s "$ERROR_MARKER" ]; then
    echo "Framework validation failed for $ROOT_DIR" >&2
    cat "$ISSUE_FILE" >&2
    exit 1
  fi

  echo "Framework validation passed with warnings for $ROOT_DIR"
  cat "$ISSUE_FILE"
  exit 0
fi

echo "Framework validation passed for $ROOT_DIR"

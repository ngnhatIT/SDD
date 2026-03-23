#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM
CANONICAL_SPECS_DIR="$ROOT_DIR/docs/specs"
SUPPORT_EXAMPLES_DIR="$ROOT_DIR/docs/specs-support/examples"
SUPPORT_FIXTURES_DIR="$ROOT_DIR/docs/specs-support/fixtures"

OUTPUT_PATH=""

usage() {
  cat >&2 <<'EOF'
Usage: sh scripts/sdd/build_spec_graph.sh <feature-id-or-path> [--output <path>]

Examples:
  sh scripts/sdd/build_spec_graph.sh 2026-03-11-example-customer-export
  sh scripts/sdd/build_spec_graph.sh docs/specs-support/examples/2026-03-11-example-customer-export
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

yaml_quote() {
  value=$1
  escaped=$(printf '%s' "$value" | sed "s/'/''/g")
  printf "'%s'" "$escaped"
}

relative_path() {
  printf '%s\n' "$1" | sed "s#^$ROOT_DIR/##"
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
        front_seen = 1
        in_front = 1
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

extract_section() {
  section_src=$1
  section_start_pattern=$2
  section_stop_pattern=$3
  section_dst=$4
  awk -v start="$section_start_pattern" -v stop="$section_stop_pattern" '
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
  ' "$section_src" > "$section_dst"
}

extract_bullets_from_file() {
  bullets_src=$1
  bullets_dst=$2
  awk '
    {
      sub(/\r$/, "", $0)
    }
    /^[[:space:]]*$/ { next }
    /^[[:space:]]*[-*][[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]*[-*][[:space:]]+/, "", line)
      if (tolower(line) !~ /^none\./) {
        print line
      }
      next
    }
    /^[[:space:]]*[0-9]+\.[[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]*[0-9]+\.[[:space:]]+/, "", line)
      if (tolower(line) !~ /^none\./) {
        print line
      }
      next
    }
    tolower($0) ~ /^none\./ { next }
  ' "$bullets_src" > "$bullets_dst"
}

extract_list_section() {
  list_src=$1
  list_start_pattern=$2
  list_stop_pattern=$3
  list_dst=$4
  list_raw="$TMP_DIR/section.raw"
  extract_section "$list_src" "$list_start_pattern" "$list_stop_pattern" "$list_raw"
  extract_bullets_from_file "$list_raw" "$list_dst"
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

infer_classification() {
  if [ -f "$FEATURE_DIR/03-data-model.md" ] || [ -f "$FEATURE_DIR/04-api-contract.md" ] || [ -f "$FEATURE_DIR/05-behavior.md" ] || [ -f "$FEATURE_DIR/06-edge-cases.md" ]; then
    printf 'full-path\n'
  else
    printf 'reduced-path\n'
  fi
}

split_anchor_list() {
  value=$1
  dst=$2
  printf '%s\n' "$value" | awk '
    BEGIN {
      FS = ";"
    }
    {
      for (i = 1; i <= NF; i++) {
        item = $i
        gsub(/`/, "", item)
        gsub(/^[[:space:]]+/, "", item)
        gsub(/[[:space:]]+$/, "", item)
        if (item != "" && item != "n/a") {
          print item
        }
      }
    }
  ' > "$dst"
}

append_warning() {
  message=$1
  if ! grep -Fqx "$message" "$WARNINGS_FILE" 2>/dev/null; then
    printf '%s\n' "$message" >> "$WARNINGS_FILE"
  fi
}

append_manual_note() {
  message=$1
  if ! grep -Fqx "$message" "$MANUAL_FILE" 2>/dev/null; then
    printf '%s\n' "$message" >> "$MANUAL_FILE"
  fi
}

extract_ids_from_text() {
  prefix=$1
  text=$2
  printf '%s\n' "$text" | awk -v prefix="$prefix" '
    function emit_range(start_str, end_str,    start_num, end_num, width, step, i) {
      start_num = start_str + 0
      end_num = end_str + 0
      width = length(start_str)
      step = (start_num <= end_num) ? 1 : -1
      for (i = start_num; ; i += step) {
        printf "%s-%0*d\n", prefix, width, i
        if (i == end_num) {
          break
        }
      }
    }
    {
      line = $0
      gsub(/`/, "", line)
      pattern = prefix "-[0-9]+"
      while (match(line, pattern "[[:space:]]*(to|through|-)[[:space:]]*" pattern)) {
        range = substr(line, RSTART, RLENGTH)
        if (match(range, prefix "-([0-9]+)[[:space:]]*(to|through|-)[[:space:]]*" prefix "-([0-9]+)", parts)) {
          emit_range(parts[1], parts[3])
        }
        line = substr(line, RSTART + RLENGTH)
      }
      while (match(line, pattern)) {
        print substr(line, RSTART, RLENGTH)
        line = substr(line, RSTART + RLENGTH)
      }
    }
  ' | awk '!seen[$0]++'
}

dedupe_by_first_column() {
  src=$1
  dst=$2
  awk -F '\t' '!seen[$1]++' "$src" > "$dst"
}

add_link() {
  type=$1
  from_id=$2
  to_id=$3
  source_file=$4
  certainty=$5
  method=$6
  [ -n "$from_id" ] || return
  [ -n "$to_id" ] || return
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$type" "$from_id" "$to_id" "$source_file" "$certainty" "$method" >> "$LINKS_RAW"
}

extract_requirements() {
  table_raw="$TMP_DIR/requirements.table.raw.tsv"
  heading_raw="$TMP_DIR/requirements.heading.raw.tsv"
  : > "$table_raw"
  : > "$heading_raw"

  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      id = trim($2)
      summary = trim($3)
      gsub(/`/, "", id)
      if (id ~ /^REQ-[0-9]+$/) {
        print id "\t" summary "\trequirements_table"
      }
    }
  ' "$REQ_FILE" >> "$table_raw"

  awk '
    function emit() {
      if (id != "") {
        summary = statement
        if (summary == "") {
          summary = "unknown (statement not explicitly stated in source)"
        }
        print id "\t" summary "\trequirements_heading"
      }
    }
    {
      sub(/\r$/, "", $0)
    }
    /^### REQ-[0-9]+/ {
      emit()
      id = $2
      statement = ""
      next
    }
    /^- Statement:/ {
      sub(/^- Statement:[[:space:]]*/, "", $0)
      statement = $0
      next
    }
    END {
      emit()
    }
  ' "$REQ_FILE" >> "$heading_raw"

  cat "$table_raw" "$heading_raw" > "$TMP_DIR/requirements.raw.tsv"
  dedupe_by_first_column "$TMP_DIR/requirements.raw.tsv" "$REQ_NODES"
}

extract_design_decisions() {
  table_raw="$TMP_DIR/design.table.raw.tsv"
  heading_raw="$TMP_DIR/design.heading.raw.tsv"
  : > "$table_raw"
  : > "$heading_raw"

  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      id = trim($2)
      summary = trim($3)
      gsub(/`/, "", id)
      if (id ~ /^DES-[0-9]+$/) {
        print id "\t" summary "\t__NONE__\tdesign_table"
      }
    }
  ' "$DESIGN_FILE" >> "$table_raw"

  awk '
    function emit() {
      if (id != "") {
        summary = decision
        if (summary == "") {
          summary = "unknown (decision not explicitly stated in source)"
        }
        print id "\t" summary "\t" reqs "\tdesign_heading"
      }
    }
    {
      sub(/\r$/, "", $0)
    }
    /^### DES-[0-9]+/ {
      emit()
      id = $2
      decision = ""
      reqs = ""
      next
    }
    /^- Decision:/ {
      sub(/^- Decision:[[:space:]]*/, "", $0)
      decision = $0
      next
    }
    /^- Requirement links:/ {
      sub(/^- Requirement links:[[:space:]]*/, "", $0)
      reqs = $0
      next
    }
    END {
      emit()
    }
  ' "$DESIGN_FILE" >> "$heading_raw"

  cat "$table_raw" "$heading_raw" > "$TMP_DIR/design.raw.tsv"
  dedupe_by_first_column "$TMP_DIR/design.raw.tsv" "$DES_NODES"
}

extract_tasks() {
  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      id = trim($2)
      summary = trim($3)
      reqs = trim($4)
      designs = trim($5)
      tests = trim($6)
      gsub(/`/, "", id)
      if (id ~ /^TASK-[0-9]+$/) {
        print id "\t" summary "\t" reqs "\t" designs "\t" tests "\ttasks_table"
      }
    }
  ' "$TASK_FILE" > "$TASK_NODES"
}

extract_acceptance() {
  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      id = trim($2)
      reqs = trim($3)
      summary = trim($4)
      gsub(/`/, "", id)
      if (id ~ /^AC-[0-9]+$/) {
        print id "\t" summary "\t" reqs "\tacceptance_table"
      }
    }
  ' "$AC_FILE" > "$AC_NODES"
}

extract_tests() {
  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      id = trim($2)
      acs = trim($3)
      test_type = trim($4)
      summary = trim($5)
      gsub(/`/, "", id)
      if (id ~ /^TC-[0-9]+$/) {
        print id "\t" summary "\t" acs "\t" test_type "\ttests_table"
      }
    }
  ' "$TEST_FILE" > "$TC_NODES"
}

extract_contracts() {
  : > "$CONTRACTS_FILE"
  if [ ! -f "$FEATURE_DIR/04-api-contract.md" ]; then
    return 0
  fi

  section="$TMP_DIR/contracts.section.md"
  refs="$TMP_DIR/contracts.refs.txt"
  extract_section "$FEATURE_DIR/04-api-contract.md" "^## Machine-Readable Contract Files$" "^## " "$section"
  awk '
    {
      sub(/\r$/, "", $0)
    }
    /^[[:space:]]*-[[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]*-[[:space:]]+/, "", line)
      print line
    }
  ' "$section" > "$refs"

  counter=1
  if [ -s "$refs" ]; then
    while IFS= read -r contract_ref; do
      [ -n "$contract_ref" ] || continue
      contract_ref=$(printf '%s' "$contract_ref" | sed 's/`//g')
      id=$(printf 'CONTRACT-%02d' "$counter")
      printf '%s\t%s\t04-api-contract.md\texplicit\tmachine_readable_contract_files_section\n' "$id" "$contract_ref" >> "$CONTRACTS_FILE"
      counter=$((counter + 1))
    done < "$refs"
  elif [ -d "$FEATURE_DIR/contracts" ]; then
    append_warning "contracts/ exists but 04-api-contract.md does not explicitly list owned machine-readable contract files; contract nodes were not inferred."
  fi
}

extract_entities() {
  : > "$ENTITIES_FILE"
  if [ ! -f "$FEATURE_DIR/03-data-model.md" ]; then
    return 0
  fi

  awk '
    {
      sub(/\r$/, "", $0)
    }
    /^### / {
      heading = $0
      sub(/^### /, "", heading)
      if (match(heading, /`([^`]+)`/, parts)) {
        print parts[1]
      }
    }
  ' "$FEATURE_DIR/03-data-model.md" | awk '!seen[$0]++' | awk '
    {
      printf "ENTITY-%02d\t%s\t03-data-model.md\texplicit\tdata_model_heading\n", NR, $0
    }
  ' > "$ENTITIES_FILE"
}

extract_design_links() {
  if [ ! -s "$DES_NODES" ]; then
    return
  fi

  while IFS=$(printf '\t') read -r des_id des_summary des_reqs des_method; do
    [ -n "$des_id" ] || continue
    if [ -n "$des_reqs" ] && [ "$des_reqs" != "__NONE__" ]; then
      extract_ids_from_text "REQ" "$des_reqs" | while IFS= read -r req_id; do
        [ -n "$req_id" ] || continue
        add_link "addresses" "$des_id" "$req_id" "02-design.md" "explicit" "$des_method"
      done
    fi
  done < "$DES_NODES"
}

extract_task_links() {
  if [ ! -s "$TASK_NODES" ]; then
    return
  fi

  while IFS=$(printf '\t') read -r task_id task_summary task_reqs task_designs task_tests task_method; do
    [ -n "$task_id" ] || continue
    extract_ids_from_text "REQ" "$task_reqs" | while IFS= read -r req_id; do
      [ -n "$req_id" ] || continue
      add_link "fulfills" "$task_id" "$req_id" "07-tasks.md" "explicit" "$task_method"
    done
    extract_ids_from_text "DES" "$task_designs" | while IFS= read -r des_id; do
      [ -n "$des_id" ] || continue
      add_link "implements" "$task_id" "$des_id" "07-tasks.md" "explicit" "$task_method"
    done
    extract_ids_from_text "TC" "$task_tests" | while IFS= read -r tc_id; do
      [ -n "$tc_id" ] || continue
      add_link "verified_by" "$task_id" "$tc_id" "07-tasks.md" "explicit" "$task_method"
    done
  done < "$TASK_NODES"
}

extract_acceptance_links() {
  if [ ! -s "$AC_NODES" ]; then
    return
  fi

  while IFS=$(printf '\t') read -r ac_id ac_summary ac_reqs ac_method; do
    [ -n "$ac_id" ] || continue
    extract_ids_from_text "REQ" "$ac_reqs" | while IFS= read -r req_id; do
      [ -n "$req_id" ] || continue
      add_link "accepts" "$ac_id" "$req_id" "08-acceptance-criteria.md" "explicit" "$ac_method"
    done
  done < "$AC_NODES"
}

extract_test_links() {
  if [ ! -s "$TC_NODES" ]; then
    return
  fi

  while IFS=$(printf '\t') read -r tc_id tc_summary tc_acs tc_type tc_method; do
    [ -n "$tc_id" ] || continue
    extract_ids_from_text "AC" "$tc_acs" | while IFS= read -r ac_id; do
      [ -n "$ac_id" ] || continue
      add_link "verifies" "$tc_id" "$ac_id" "09-test-cases.md" "explicit" "$tc_method"
    done
  done < "$TC_NODES"
}

extract_readme_traceability_links() {
  trace_raw="$TMP_DIR/readme.traceability.tsv"
  : > "$trace_raw"

  awk -F '|' '
    function trim(s) {
      gsub(/^[[:space:]]+/, "", s)
      gsub(/[[:space:]]+$/, "", s)
      return s
    }
    /^\|/ {
      req = trim($2)
      des = trim($3)
      task = trim($4)
      ac = trim($5)
      tc = trim($6)
      gsub(/`/, "", req)
      if (req ~ /^REQ-[0-9]+$/) {
        print req "\t" des "\t" task "\t" ac "\t" tc
      }
    }
  ' "$README_FILE" > "$trace_raw"

  if [ ! -s "$trace_raw" ]; then
    append_warning "README.md does not expose a parseable traceability table for fallback DES -> REQ extraction."
    return
  fi

  while IFS=$(printf '\t') read -r req_id des_cell task_cell ac_cell tc_cell; do
    [ -n "$req_id" ] || continue
    extract_ids_from_text "DES" "$des_cell" | while IFS= read -r des_id; do
      [ -n "$des_id" ] || continue
      add_link "addresses" "$des_id" "$req_id" "README.md" "explicit" "readme_traceability_table"
    done
  done < "$trace_raw"
}

emit_string_list() {
  indent=$1
  file=$2
  if [ ! -s "$file" ]; then
    printf ' []\n'
    return
  fi
  echo
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    printf '%s- %s\n' "$indent" "$(yaml_quote "$item")"
  done < "$file"
}

emit_anchor_list() {
  indent=$1
  file=$2
  if [ ! -s "$file" ]; then
    printf ' []\n'
    return
  fi
  echo
  while IFS= read -r item; do
    [ -n "$item" ] || continue
    printf '%s- %s\n' "$indent" "$(yaml_quote "$item")"
  done < "$file"
}

emit_nodes() {
  if [ ! -s "$1" ] && [ ! -s "$2" ] && [ ! -s "$3" ] && [ ! -s "$4" ] && [ ! -s "$5" ]; then
    echo " []"
    return
  fi

  echo
  for src in "$1" "$2" "$3" "$4" "$5"; do
    [ -s "$src" ] || continue
    while IFS=$(printf '\t') read -r node_id summary third fourth fifth sixth; do
      [ -n "$node_id" ] || continue
      case "$src" in
        "$REQ_NODES")
          kind="requirement"
          method=$third
          source_file="01-requirements.md"
          ;;
        "$DES_NODES")
          kind="decision"
          method=$fourth
          source_file="02-design.md"
          ;;
        "$TASK_NODES")
          kind="task"
          method=$sixth
          source_file="07-tasks.md"
          ;;
        "$AC_NODES")
          kind="acceptance"
          method=$fourth
          source_file="08-acceptance-criteria.md"
          ;;
        "$TC_NODES")
          kind="test"
          method=$fifth
          source_file="09-test-cases.md"
          ;;
      esac
      printf '  - id: %s\n' "$(yaml_quote "$node_id")"
      printf '    kind: %s\n' "$(yaml_quote "$kind")"
      printf '    source_file: %s\n' "$(yaml_quote "$source_file")"
      printf '    summary: %s\n' "$(yaml_quote "$summary")"
      if [ "$kind" = "test" ]; then
        printf '    test_type: %s\n' "$(yaml_quote "$fourth")"
      fi
      printf '    certainty: %s\n' "$(yaml_quote "explicit")"
      printf '    method: %s\n' "$(yaml_quote "$method")"
    done < "$src"
  done
}

emit_contracts() {
  if [ ! -s "$CONTRACTS_FILE" ]; then
    echo " []"
    return
  fi
  echo
  while IFS=$(printf '\t') read -r contract_id contract_path source_file certainty method; do
    [ -n "$contract_id" ] || continue
    printf '  - id: %s\n' "$(yaml_quote "$contract_id")"
    printf '    path: %s\n' "$(yaml_quote "$contract_path")"
    printf '    source_file: %s\n' "$(yaml_quote "$source_file")"
    printf '    certainty: %s\n' "$(yaml_quote "$certainty")"
    printf '    method: %s\n' "$(yaml_quote "$method")"
  done < "$CONTRACTS_FILE"
}

emit_entities() {
  if [ ! -s "$ENTITIES_FILE" ]; then
    echo " []"
    return
  fi
  echo
  while IFS=$(printf '\t') read -r entity_id entity_name source_file certainty method; do
    [ -n "$entity_id" ] || continue
    printf '  - id: %s\n' "$(yaml_quote "$entity_id")"
    printf '    name: %s\n' "$(yaml_quote "$entity_name")"
    printf '    source_file: %s\n' "$(yaml_quote "$source_file")"
    printf '    certainty: %s\n' "$(yaml_quote "$certainty")"
    printf '    method: %s\n' "$(yaml_quote "$method")"
  done < "$ENTITIES_FILE"
}

emit_links() {
  LINKS_DEDUP="$TMP_DIR/links.dedup.tsv"
  if [ -s "$LINKS_RAW" ]; then
    awk -F '\t' '!seen[$1 FS $2 FS $3]++' "$LINKS_RAW" > "$LINKS_DEDUP"
  else
    : > "$LINKS_DEDUP"
  fi

  if [ ! -s "$LINKS_DEDUP" ]; then
    echo " []"
    return
  fi

  echo
  while IFS=$(printf '\t') read -r link_type from_id to_id source_file certainty method; do
    [ -n "$link_type" ] || continue
    printf '  - type: %s\n' "$(yaml_quote "$link_type")"
    printf '    from: %s\n' "$(yaml_quote "$from_id")"
    printf '    to: %s\n' "$(yaml_quote "$to_id")"
    printf '    source_file: %s\n' "$(yaml_quote "$source_file")"
    printf '    certainty: %s\n' "$(yaml_quote "$certainty")"
    printf '    method: %s\n' "$(yaml_quote "$method")"
  done < "$LINKS_DEDUP"
}

[ $# -ge 1 ] || usage

FEATURE_ARG=$1
shift

while [ $# -gt 0 ]; do
  case "$1" in
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

for required_file in "$README_FILE" "$REQ_FILE" "$DESIGN_FILE" "$TASK_FILE" "$AC_FILE" "$TEST_FILE"; do
  [ -f "$required_file" ] || {
    echo "Missing required feature artifact: $(relative_path "$required_file")" >&2
    exit 1
  }
done

FEATURE_ID=$(scalar_front_matter "$README_FILE" id)
[ -n "$FEATURE_ID" ] || FEATURE_ID=$(basename "$FEATURE_DIR")
FEATURE_TITLE=$(scalar_front_matter "$README_FILE" title)
FEATURE_OWNER=$(scalar_front_matter "$README_FILE" owner)
FEATURE_STATUS=$(scalar_front_matter "$README_FILE" status)
FEATURE_UPDATED=$(scalar_front_matter "$README_FILE" last_updated)
CLASSIFICATION=$(infer_classification)

if [ -z "$OUTPUT_PATH" ]; then
  FINAL_OUTPUT="$FEATURE_DIR/spec.graph.yaml"
else
  case "$OUTPUT_PATH" in
    /*|[A-Za-z]:/*)
      FINAL_OUTPUT="$OUTPUT_PATH"
      ;;
    *)
      FINAL_OUTPUT="$ROOT_DIR/$OUTPUT_PATH"
      ;;
  esac
fi

mkdir -p "$(dirname "$FINAL_OUTPUT")"

REQ_NODES="$TMP_DIR/requirements.tsv"
DES_NODES="$TMP_DIR/design.tsv"
TASK_NODES="$TMP_DIR/tasks.tsv"
AC_NODES="$TMP_DIR/acceptance.tsv"
TC_NODES="$TMP_DIR/tests.tsv"
CONTRACTS_FILE="$TMP_DIR/contracts.tsv"
ENTITIES_FILE="$TMP_DIR/entities.tsv"
LINKS_RAW="$TMP_DIR/links.raw.tsv"
WARNINGS_FILE="$TMP_DIR/warnings.txt"
MANUAL_FILE="$TMP_DIR/manual.txt"
: > "$LINKS_RAW"
: > "$WARNINGS_FILE"
: > "$MANUAL_FILE"

IN_SCOPE_FILE="$TMP_DIR/in-scope.txt"
OUT_SCOPE_FILE="$TMP_DIR/out-of-scope.txt"
NON_CHANGES_FILE="$TMP_DIR/non-changes.txt"
OPEN_QUESTIONS_FILE="$TMP_DIR/open-questions.txt"

extract_list_section "$README_FILE" "^### In Scope$" "^### |^## " "$IN_SCOPE_FILE"
extract_list_section "$README_FILE" "^### Out Of Scope$" "^### |^## " "$OUT_SCOPE_FILE"
extract_list_section "$DESIGN_FILE" "^## Non-Changes$" "^## " "$NON_CHANGES_FILE"
extract_list_section "$README_FILE" "^## Open Questions$" "^## " "$OPEN_QUESTIONS_FILE"

if [ ! -s "$IN_SCOPE_FILE" ]; then
  extract_list_section "$REQ_FILE" "^## In Scope$" "^## " "$IN_SCOPE_FILE"
fi

if [ ! -s "$OUT_SCOPE_FILE" ]; then
  extract_list_section "$REQ_FILE" "^## Out Of Scope$" "^## " "$OUT_SCOPE_FILE"
fi

BACKEND_PROCESS_ANCHORS="$TMP_DIR/anchor.backend_process.txt"
BACKEND_WEBSERVICE_ANCHORS="$TMP_DIR/anchor.backend_webservice.txt"
SQL_ANCHORS="$TMP_DIR/anchor.sql.txt"
FRONTEND_TS_ANCHORS="$TMP_DIR/anchor.frontend_ts.txt"
FRONTEND_HTML_ANCHORS="$TMP_DIR/anchor.frontend_html.txt"

split_anchor_list "$(anchor_value 'Backend process anchor files:')" "$BACKEND_PROCESS_ANCHORS"
split_anchor_list "$(anchor_value 'Backend webservice anchor files:')" "$BACKEND_WEBSERVICE_ANCHORS"
split_anchor_list "$(anchor_value 'SQL anchor files:')" "$SQL_ANCHORS"
split_anchor_list "$(anchor_value 'Frontend .ts anchor files:')" "$FRONTEND_TS_ANCHORS"
split_anchor_list "$(anchor_value 'Frontend .html anchor files:')" "$FRONTEND_HTML_ANCHORS"

DOMINANT_STYLE_NOTE=$(trim "$(anchor_value 'Dominant module/style note:')")
NEW_STRUCTURE_SCOPE=$(trim "$(anchor_value 'New tables/source families/screen structure in scope:')")

extract_requirements
extract_design_decisions
extract_tasks
extract_acceptance
extract_tests
extract_contracts
extract_entities

extract_design_links
extract_task_links
extract_acceptance_links
extract_test_links
extract_readme_traceability_links

append_manual_note "Contract-to-requirement and contract-to-decision links still require human authoring unless the markdown states them explicitly."
append_manual_note "Entity-or-table links to requirements, decisions, or tasks still require human authoring unless the markdown states them explicitly."
append_manual_note "Touched component nodes beyond the source-base anchor file lists are not extracted in this first pass."

if [ -s "$CONTRACTS_FILE" ]; then
  append_warning "Contract files were extracted, but their links to requirements or decisions remain manual unless explicitly stated in markdown."
fi

if [ -s "$ENTITIES_FILE" ]; then
  append_warning "Entity-or-table nodes were extracted from 03-data-model.md headings, but their trace links remain manual unless explicitly stated elsewhere."
fi

if [ ! -s "$DES_NODES" ]; then
  append_warning "No parseable DES nodes were extracted from 02-design.md."
fi

if [ ! -s "$REQ_NODES" ]; then
  append_warning "No parseable REQ nodes were extracted from 01-requirements.md."
fi

if ! awk -F '\t' '$1 == "addresses" { found = 1 } END { exit(found ? 0 : 1) }' "$LINKS_RAW"; then
  append_warning "No explicit DES -> REQ links were extracted; add them manually if downstream tooling needs them."
fi

{
  echo "schema_version: 1"
  echo "feature:"
  echo "  id: $(yaml_quote "$FEATURE_ID")"
  echo "  title: $(yaml_quote "$FEATURE_TITLE")"
  echo "  owner: $(yaml_quote "$FEATURE_OWNER")"
  echo "  status: $(yaml_quote "$FEATURE_STATUS")"
  echo "  last_updated: $(yaml_quote "$FEATURE_UPDATED")"
  echo "  classification: $(yaml_quote "$CLASSIFICATION")"
  echo "  package_root: $(yaml_quote "$(relative_path "$FEATURE_DIR")")"
  printf '  related_specs:'
  list_front_matter "$README_FILE" related_specs > "$TMP_DIR/feature.related_specs.txt"
  emit_string_list "    " "$TMP_DIR/feature.related_specs.txt"
  printf '  dependencies:'
  list_front_matter "$README_FILE" dependencies > "$TMP_DIR/feature.dependencies.txt"
  emit_string_list "    " "$TMP_DIR/feature.dependencies.txt"
  printf '  implementation_refs:'
  list_front_matter "$README_FILE" implementation_refs > "$TMP_DIR/feature.implementation_refs.txt"
  emit_string_list "    " "$TMP_DIR/feature.implementation_refs.txt"
  printf '  test_refs:'
  list_front_matter "$README_FILE" test_refs > "$TMP_DIR/feature.test_refs.txt"
  emit_string_list "    " "$TMP_DIR/feature.test_refs.txt"
  echo "scope:"
  printf '  in_scope:'
  emit_string_list "    " "$IN_SCOPE_FILE"
  printf '  out_of_scope:'
  emit_string_list "    " "$OUT_SCOPE_FILE"
  printf '  non_changes:'
  emit_string_list "    " "$NON_CHANGES_FILE"
  printf '  open_questions:'
  emit_string_list "    " "$OPEN_QUESTIONS_FILE"
  echo "anchors:"
  printf '  backend_process_files:'
  emit_anchor_list "    " "$BACKEND_PROCESS_ANCHORS"
  printf '  backend_webservice_files:'
  emit_anchor_list "    " "$BACKEND_WEBSERVICE_ANCHORS"
  printf '  sql_files:'
  emit_anchor_list "    " "$SQL_ANCHORS"
  printf '  frontend_ts_files:'
  emit_anchor_list "    " "$FRONTEND_TS_ANCHORS"
  printf '  frontend_html_files:'
  emit_anchor_list "    " "$FRONTEND_HTML_ANCHORS"
  echo "  dominant_style_note: $(yaml_quote "$DOMINANT_STYLE_NOTE")"
  echo "  new_structure_scope: $(yaml_quote "$NEW_STRUCTURE_SCOPE")"
  printf 'contracts:'
  emit_contracts
  printf 'entities:'
  emit_entities
  printf 'nodes:'
  emit_nodes "$REQ_NODES" "$DES_NODES" "$TASK_NODES" "$AC_NODES" "$TC_NODES"
  printf 'links:'
  emit_links
  echo "extraction:"
  echo "  notes:"
  echo "    - $(yaml_quote "This graph is generated from canonical markdown and is not an approval artifact.")"
  echo "    - $(yaml_quote "Only explicit nodes and links are extracted in this first pass.")"
  printf '  warnings:'
  emit_string_list "    " "$WARNINGS_FILE"
  printf '  manual_authoring_needed:'
  emit_string_list "    " "$MANUAL_FILE"
} > "$FINAL_OUTPUT"

echo "Spec graph generated: $(relative_path "$FINAL_OUTPUT")"

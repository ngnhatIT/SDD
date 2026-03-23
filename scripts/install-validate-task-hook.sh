#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "usage: scripts/install-validate-task-hook.sh <task-folder> <task-type> [extra validate-task args...]" >&2
  exit 1
fi

task_folder="$1"
shift
task_type="$1"
shift || true

hook_path=".git/hooks/pre-commit"
mkdir -p "$(dirname "$hook_path")"
cat > "$hook_path" <<HOOK
#!/usr/bin/env bash
set -euo pipefail
python3 scripts/validate-task.py "$task_folder" "$task_type" "$@"
HOOK
chmod +x "$hook_path"
echo "installed optional pre-commit hook at $hook_path"

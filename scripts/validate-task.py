#!/usr/bin/env python3

from __future__ import annotations

import argparse
import sys
from pathlib import Path


TASK_REQUIREMENTS = {
    "spec": ("spec_pack.md", "verification.md"),
    "code": ("spec_pack.md", "verification.md"),
    "implement": ("spec_pack.md", "verification.md"),
    "fix": ("spec_pack.md", "verification.md"),
    "docs": ("spec_pack.md", "verification.md"),
    "hotfix": ("spec_pack.md", "verification.md"),
    "review": ("review.md",),
    "audit": ("audit.md",),
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate the minimum required task artifacts for a governed task folder."
    )
    parser.add_argument("task_folder", help="Path to the governed task folder.")
    parser.add_argument("task_type", help="Task type or alias.")
    parser.add_argument(
        "--non-trivial",
        action="store_true",
        help="Require reinforcement.md for non-trivial governed work.",
    )
    return parser.parse_args()


def fail(message: str) -> int:
    print(message, file=sys.stderr)
    return 1


def main() -> int:
    args = parse_args()
    task_type = args.task_type.strip().lower()

    if task_type not in TASK_REQUIREMENTS:
        supported = ", ".join(sorted(TASK_REQUIREMENTS))
        return fail(
            f"validation failed: unknown task type '{args.task_type}'. "
            f"Supported task types: {supported}."
        )

    task_folder = Path(args.task_folder).expanduser().resolve()

    if not task_folder.exists():
        return fail(
            f"validation failed: task folder '{task_folder}' does not exist."
        )
    if not task_folder.is_dir():
        return fail(
            f"validation failed: task folder '{task_folder}' is not a directory."
        )

    required_files = list(TASK_REQUIREMENTS[task_type])
    if args.non_trivial:
        required_files.append("reinforcement.md")

    missing_files = [
        file_name for file_name in required_files if not (task_folder / file_name).is_file()
    ]

    if missing_files:
        print(
            f"validation failed for task type '{task_type}' at '{task_folder}':",
            file=sys.stderr,
        )
        for file_name in missing_files:
            print(f"- missing required file: {file_name}", file=sys.stderr)
        if args.non_trivial:
            print(
                "- --non-trivial was set, so reinforcement.md is required.",
                file=sys.stderr,
            )
        return 1

    print(f"validation passed for task type '{task_type}' at '{task_folder}'.")
    print("checked files:")
    for file_name in required_files:
        print(f"- {file_name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

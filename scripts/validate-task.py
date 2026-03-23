#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from typing import Iterable

CANONICAL_TASK_TYPES = {
    "implement": ("spec_pack.md", "verification.md"),
    "fix": ("spec_pack.md", "verification.md"),
    "docs": ("spec_pack.md", "verification.md"),
    "hotfix": ("spec_pack.md", "verification.md"),
    "review": ("spec_pack.md", "review.md"),
    "audit": ("spec_pack.md", "audit.md"),
}

PLACEHOLDER_PATTERNS = [
    re.compile(pattern, re.IGNORECASE | re.MULTILINE)
    for pattern in (
        r"^\s*(todo|tbd|pending|placeholder|lorem ipsum|n/?a|none)\s*$",
        r"\bin progress\b",
    )
]

SECTION_PATTERNS = {
    "spec_pack.md": {
        "section": [r"^##+\s+", r"^###\s+"],
        "acceptance": [r"acceptance criteria", r"acceptance", r"success criteria"],
    },
    "reinforcement.md": {
        "rule": [r"\brule(s)?\b", r"\bconstraint(s)?\b", r"\bstop condition(s)?\b"],
    },
    "verification.md": {
        "verification": [r"verification step(s)?", r"checklist", r"test(s)? run", r"acceptance coverage"],
    },
    "review.md": {
        "findings": [r"\bfindings\b"],
        "scope": [r"scope reviewed", r"files inspected", r"scope and basis"],
        "spec_reference": [r"spec_pack\.md", r"originating spec", r"feature pack"],
    },
    "audit.md": {
        "compliance": [r"compliance status", r"\bpass\b", r"\bfail\b", r"\bpartial\b"],
        "no_code_change": [r"code modified:\s*no", r"no code modification", r"no code modified"],
        "spec_reference": [r"spec_pack\.md", r"originating spec", r"feature pack"],
    },
}

STRICT_PATTERNS = {
    "spec_pack.md": {
        "requirements": [r"functional requirements", r"\bfr-\d+\b"],
    },
    "reinforcement.md": {
        "grounding": [r"grounded sources", r"consistency checks"],
    },
    "verification.md": {
        "summary": [r"summary of changes"],
    },
    "review.md": {
        "files": [r"files inspected"],
        "risks": [r"residual risks"],
    },
    "audit.md": {
        "basis": [r"scope and basis"],
        "follow_up": [r"follow-up", r"residual risks"],
    },
}



def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate governed task artifacts for a task folder."
    )
    parser.add_argument("task_folder", help="Path to the governed task folder.")
    parser.add_argument(
        "task_type",
        help="Canonical task type: implement, fix, docs, hotfix, review, or audit.",
    )
    parser.add_argument(
        "--non-trivial",
        action="store_true",
        help="Require reinforcement.md for non-trivial governed work.",
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Enable stronger section checks for each required artifact.",
    )
    return parser.parse_args()


def fail(message: str) -> int:
    print(message, file=sys.stderr)
    return 1


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def has_pattern(text: str, patterns: Iterable[str]) -> bool:
    return any(re.search(pattern, text, re.IGNORECASE | re.MULTILINE) for pattern in patterns)


def find_placeholder_lines(text: str) -> list[str]:
    matches: list[str] = []
    for line in text.splitlines():
        stripped = line.strip(" -`*")
        if not stripped:
            continue
        for pattern in PLACEHOLDER_PATTERNS:
            if pattern.search(stripped):
                matches.append(line.strip())
                break
    return matches


def validate_content(file_name: str, text: str, strict: bool) -> list[str]:
    errors: list[str] = []
    if not text.strip():
        return ["file is empty"]

    placeholders = find_placeholder_lines(text)
    if placeholders:
        errors.append(f"contains placeholder content: {', '.join(placeholders[:3])}")

    rules = SECTION_PATTERNS.get(file_name, {})
    for label, patterns in rules.items():
        if not has_pattern(text, patterns):
            errors.append(f"missing required {label} marker")

    if strict:
        for label, patterns in STRICT_PATTERNS.get(file_name, {}).items():
            if not has_pattern(text, patterns):
                errors.append(f"strict mode: missing {label} marker")

    return errors


def validate_structure(task_folder: Path) -> list[str]:
    errors: list[str] = []
    name = task_folder.name
    if not re.fullmatch(r"\d{4}-\d{2}-\d{2}-[a-z0-9]+(?:-[a-z0-9]+)*", name):
        errors.append(
            "folder name must use canonical date-first slug format YYYY-MM-DD-short-slug"
        )
    return errors


def main() -> int:
    args = parse_args()
    task_type = args.task_type.strip().lower()

    if task_type not in CANONICAL_TASK_TYPES:
        supported = ", ".join(sorted(CANONICAL_TASK_TYPES))
        return fail(
            f"validation failed: unknown task type '{args.task_type}'. "
            f"Supported canonical task types: {supported}."
        )

    task_folder = Path(args.task_folder).expanduser().resolve()
    if not task_folder.exists():
        return fail(f"validation failed: task folder '{task_folder}' does not exist.")
    if not task_folder.is_dir():
        return fail(f"validation failed: task folder '{task_folder}' is not a directory.")

    required_files = list(CANONICAL_TASK_TYPES[task_type])
    if args.non_trivial:
        required_files.append("reinforcement.md")

    errors: list[str] = []
    errors.extend(validate_structure(task_folder))

    missing_files = [
        file_name for file_name in required_files if not (task_folder / file_name).is_file()
    ]
    for file_name in missing_files:
        errors.append(f"missing required file: {file_name}")

    checked_files: list[str] = []
    for file_name in required_files:
        path = task_folder / file_name
        if not path.is_file():
            continue
        checked_files.append(file_name)
        for message in validate_content(file_name, read_text(path), args.strict):
            errors.append(f"{file_name}: {message}")

    if errors:
        print(
            f"validation failed for task type '{task_type}' at '{task_folder}':",
            file=sys.stderr,
        )
        for message in errors:
            print(f"- {message}", file=sys.stderr)
        if args.non_trivial and "missing required file: reinforcement.md" in errors:
            print("- reinforcement.md is required because --non-trivial was set.", file=sys.stderr)
        return 1

    print(f"validation passed for task type '{task_type}' at '{task_folder}'.")
    print("checked files:")
    for file_name in checked_files:
        print(f"- {file_name}")
    if args.non_trivial and "reinforcement.md" not in checked_files:
        print("- reinforcement.md")
    if args.strict:
        print("strict mode: enabled")
    return 0


if __name__ == "__main__":
    sys.exit(main())

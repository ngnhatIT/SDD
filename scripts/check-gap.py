#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

FILE_PATTERN = re.compile(r"`([^`]+\.[A-Za-z0-9]+)`")
TOKEN_LINE_PATTERN = re.compile(r"\b(module|file|files|function|functions|endpoint|endpoints|class|classes|screen|screens)\b", re.IGNORECASE)
BACKTICK_TOKEN_PATTERN = re.compile(r"`([A-Za-z_][A-Za-z0-9_./-]*)`")
BARE_TOKEN_PATTERN = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]{2,})\b")
IGNORE_TOKENS = {"module", "modules", "file", "files", "function", "functions", "endpoint", "endpoints", "class", "classes", "screen", "screens"}
SEARCH_EXTENSIONS = {".py", ".md", ".java", ".js", ".ts", ".tsx", ".jsx", ".json", ".yaml", ".yml", ".xml", ".sh"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Lightweight spec-to-code gap check.")
    parser.add_argument("spec_target", help="Path to spec_pack.md or its containing folder.")
    return parser.parse_args()


def repo_root() -> Path:
    return Path(__file__).resolve().parents[1]


def load_spec(target: str) -> tuple[Path, str]:
    path = Path(target).expanduser().resolve()
    if path.is_dir():
        path = path / "spec_pack.md"
    if not path.is_file():
        raise FileNotFoundError(f"spec target '{path}' does not exist")
    return path, path.read_text(encoding="utf-8")


def extract_file_refs(text: str) -> list[str]:
    refs = []
    for match in FILE_PATTERN.finditer(text):
        ref = match.group(1)
        if "/" in ref or ref.endswith(".md"):
            refs.append(ref)
    return sorted(set(refs))


def extract_named_tokens(text: str) -> list[str]:
    tokens: set[str] = set()
    for line in text.splitlines():
        if not TOKEN_LINE_PATTERN.search(line):
            continue
        for match in BACKTICK_TOKEN_PATTERN.finditer(line):
            token = match.group(1)
            if "/" not in token and "." not in token:
                tokens.add(token)
        if "`" in line:
            continue
        for match in BARE_TOKEN_PATTERN.finditer(line):
            token = match.group(1)
            if token.lower() in IGNORE_TOKENS:
                continue
            tokens.add(token)
    return sorted(tokens)


def tracked_files(root: Path) -> list[Path]:
    files = []
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        if ".git" in path.parts or "archive" in path.parts:
            continue
        if path.suffix.lower() not in SEARCH_EXTENSIONS:
            continue
        files.append(path)
    return files


def token_exists(token: str, files: list[Path]) -> bool:
    for path in files:
        try:
            if token in path.read_text(encoding="utf-8"):
                return True
        except UnicodeDecodeError:
            continue
    return False


def main() -> int:
    try:
        args = parse_args()
        spec_path, text = load_spec(args.spec_target)
    except FileNotFoundError as exc:
        print(f"gap check failed: {exc}", file=sys.stderr)
        return 1

    root = repo_root()
    file_refs = extract_file_refs(text)
    tokens = extract_named_tokens(text)
    searchable_files = tracked_files(root)

    missing_files = [
        ref for ref in file_refs
        if not (root / ref).exists() and not (spec_path.parent / ref).exists()
    ]
    missing_tokens = [token for token in tokens if not token_exists(token, searchable_files)]

    print(f"gap report for {spec_path}:")
    print(f"- referenced files checked: {len(file_refs)}")
    print(f"- named tokens checked: {len(tokens)}")
    print(f"- missing referenced files: {len(missing_files)}")
    for ref in missing_files:
        print(f"  - {ref}")
    print(f"- missing named tokens: {len(missing_tokens)}")
    for token in missing_tokens:
        print(f"  - {token}")

    return 1 if missing_files or missing_tokens else 0


if __name__ == "__main__":
    sys.exit(main())

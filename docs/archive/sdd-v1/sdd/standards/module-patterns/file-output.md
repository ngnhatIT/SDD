# File Output Module Patterns

## When To Use

Use this file when a feature creates, downloads, or streams PDFs, Excel files, or other generated files.

## How To Use

Match the existing create/download split and keep format-specific logic in the format-specific package.

## Required Output

- file-output flow documented in `02-design.md`
- rollout and verification notes for create and download behavior

## Gate

Do not combine create and download behavior into a new pattern when the touched module family already separates them.

## Rules

- file output features are often split into create and download actions
- PDF, Excel, cloud download, and generic file download use shared abstractions plus feature-specific packages
- reuse shared file DTOs and abstract file processes where the surrounding module family already does so

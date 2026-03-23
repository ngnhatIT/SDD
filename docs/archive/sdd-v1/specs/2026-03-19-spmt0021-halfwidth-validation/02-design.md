---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation design"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "05-behavior.md"
  - "07-tasks.md"
---

# Design

## Overview

Keep `SPMT0021` on the existing `BaseComponent.validateFields(...)` path, but replace the current kana-only validation for the three targeted fields with a half-width-character rule that matches the requested behavior and existing inline error-routing pattern.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/spmt0021regist/process/Spmt0021RegistProcess.java`; `src/main/java/jp/co/brycen/kikancen/spmt0021update/process/Spmt0021UpdateProcess.java`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spmt0021/spmt0021.component.ts`; `src/main/webapp/angular/src/app/components/common/base/base.component.ts`; `src/main/webapp/angular/src/app/common/IFieldValidateConfig.ts`; `src/main/webapp/angular/src/app/components/spmt00021/spmt00021.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spmt0021/spmt0021.component.html`; `src/main/webapp/angular/src/app/components/spmt00021/spmt00021.component.html`
- Dominant module/style note: Preserve the `BaseComponent.validateFields(...)` plus inline `.inputError` flow in `SPMT0021`, reuse message-ID-driven validation, and align the three half-width fields with the broader half-width-character expectation already visible in sibling screen `SPMT00021`.
- New tables/source families/screen structure in scope: `no`

## Implementation Plan

- Extend `IFieldValidateConfig` and `BaseComponent` with one explicit half-width-character validation option so `SPMT0021` can stay inside the shared field-validation pipeline.
- Update only the three targeted `SPMT0021` field configs from kana-restricted checks to the new half-width-character check.
- Keep `spmt0021.component.html` unchanged because the current markup already binds messages inline under the correct inputs.
- Keep backend `Spmt0021RegistProcess` and `Spmt0021UpdateProcess` unchanged because inspected code shows no matching server-side pattern validation to realign in this fix.
- Remove no unrelated logic and avoid structural refactors beyond the minimum shared validation hook.

## Reuse And Pattern Classification

- Preferred current pattern: use `BaseComponent.validateFields(...)` for field validation and `.inputError` for inline rendering.
- Preferred current pattern: reuse shared validation helpers and message IDs instead of adding a screen-local popup or ad-hoc regex path.
- Tolerated legacy pattern in `SPMT0021`: `checkHalfWidthKatakana` and `checkAddressPattern(...KANA)` for these three fields are narrower than the requested behavior.
- Required migration in this fix: move the three targeted fields to a half-width-character rule while preserving the same field-message binding path.

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add one shared `validateFields(...)` option for half-width-character validation so `SPMT0021` can reuse the established base-component flow. | `REQ-01`, `REQ-02` |
| `DES-02` | Bind the three targeted fields to the half-width-character rule and the `ME100067` error semantics for invalid non-half-width input. | `REQ-01`, `REQ-02` |
| `DES-03` | Keep `SPMT0021` HTML structure, backend register/update processing, and all non-targeted field validations unchanged. | `REQ-03` |

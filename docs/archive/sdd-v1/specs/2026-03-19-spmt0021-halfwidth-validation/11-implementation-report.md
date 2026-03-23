---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation implementation report"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Implementation Report

## Summary

- Completed the bounded frontend validation fix for `SPMT0021` and kept scope limited to the three requested fields plus the shared base-validation hook needed to express the rule.

## Implemented Changes

- Added one `IFieldValidateConfig` option for half-width-character validation.
- Extended `BaseComponent.validateFields(...)` with a `checkHalfWidthCharacter` branch that enforces all half-width characters and returns `ME100067`.
- Updated `spmt0021.component.ts` so `factoryKanaNm`, `addrKanaLine1`, and `addrKanaLine2` use the half-width-character rule instead of the narrower kana-only checks.
- Re-inspected `Spmt0021RegistProcess` and `Spmt0021UpdateProcess`; no backend change was required because the current server-side flow does not enforce the narrowed character pattern.

## Verification Evidence

- `TC-01` / `TC-02`: source inspection confirms the three targeted field configs now route through the new half-width-character validator, which accepts ASCII half-width characters plus half-width kana (`^[ｦ-ﾟ -~]*$`) and raises `ME100067` for invalid non-half-width input.
- `TC-03`: inspected `src/main/java/jp/co/brycen/kikancen/spmt0021regist/process/Spmt0021RegistProcess.java` and `src/main/java/jp/co/brycen/kikancen/spmt0021update/process/Spmt0021UpdateProcess.java`; no matching server-side character-pattern validation changed.
- Frontend compile/build evidence: `npm run build` succeeded in `src/main/webapp/angular` on 2026-03-19. Existing Angular/CSS budget and selector warnings were emitted, but the build completed successfully and no new tracked generated files were introduced by this fix.
- Self-review result: no blocking self-findings remained after diff review against the governed package and touched-scope checklist.

## Residual Risks

- Manual browser verification on the live `SPMT0021` screen was not executed in this pass, so IME-specific input behavior is inferred from the updated validation path rather than observed end-to-end.
- Confidence: high for the scoped frontend validation change because the affected fields are explicitly mapped, the shared base-validation hook is compile-verified, and backend non-change scope was re-inspected.

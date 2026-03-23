# Auto Codebase Rules

## When To Use

Use when AI must choose between multiple possible local patterns.

## Promotion Rule

A repository-derived rule may be enforced only when repeated repository evidence or existing canonical standards already document it.

When evidence is mixed, promote the rule with an explicit status:

- `preferred current pattern`: the repository now expects new or touched code to move toward this shared or repeated pattern
- `tolerated legacy pattern`: live older code may remain untouched, but it is not valid precedent for extending the weaker pattern inside a scope that already supports the preferred current path
- `required migration pattern`: the touched scope already intersects the preferred current path strongly enough that implementation and review must either migrate or record a grounded exception

## Lifecycle Coverage

These promoted rules apply during analysis, create-feature or update-feature spec work, task planning, implementation, bug fixing, refactor, self-review, formal review, frontend changes, and backend changes.

## Core Rules

- Reuse the touched family's existing code shape before proposing a new one.
- Prefer the dominant local pattern over a generic AI cleanup pattern.
- A new pattern requires explicit approval in `02-design.md` or an ADR.
- Reuse promoted shared helpers, constants, message catalogs, and base or common flows before extending a weaker file-local duplicate in the touched scope.

## Concrete Repository-Derived Rule: Touched-Scope Import Cleanup, Formatting, And Redundant Code Removal

Rule:

- Remove unused imports from touched files before completion; do not limit cleanup to imports added in the current hunk.
- Align touched formatting, line wrapping, and local code shape with the named anchors instead of leaving mixed formatting behind.
- Remove redundant variables, dead branches, duplicated guard code, and commented-out placeholder blocks inside the touched scope when the cleanup is safe and grounded.
- Keep cleanup scoped to the touched files or module family; do not widen into unrelated churn.

Status:

- `preferred current pattern`: touched files finish without unused imports or obvious redundant placeholder code and stay formatted like their local anchors
- `tolerated legacy pattern`: untouched older files may still contain stale imports, commented-out blocks, or weaker formatting
- `required migration pattern`: any touched file that already contains obvious unused imports or dead placeholder code in the same edited scope

## Concrete Repository-Derived Rule: Frontend Screen-Family Structure Reuse

Rule:

- Reuse the touched screen family's component folder, shared service, DTO, helper, and table configuration structure before adding a new one.
- Treat `BaseComponent`, `SearchConditionManagementService`, `generateColumns(...)`, `fnGetColumnTableConfig()`, shared transport services, and `SubWindow` as the promoted structure when sibling anchors already use them for the same concern.
- Do not invent repository, facade, store, hook, model, or helper layers for one screen when the touched family does not already own that structure.
- Add a screen-owned service or `.dto.ts` only when the sibling anchors already use that shape or the approved design explicitly opens that scope.

Status:

- `preferred current pattern`: screen-family component folders that extend `BaseComponent` and reuse shared services, modal helpers, saved-condition helpers, and shared table builders where that family already supports them
- `tolerated legacy pattern`: older screens with more component-local logic or inconsistent helper splits that remain untouched
- `required migration pattern`: touched screens whose sibling anchors already rely on the promoted shared structure for the same concern

## Concrete Repository-Derived Rule: Java SQL Assembly Style

Rule:

- In Java families that build inline SQL, prefer clause-by-clause `StringBuilder.append()` assembly with uppercase SQL keywords and `?` placeholders.
- Do not introduce new long `+`-concatenated SQL fragments in touched code.
- Keep timestamp-function and SQL helper splits aligned with the chosen anchor family instead of mixing styles casually.
- Preserve the chosen anchor family's `TMT050` lookup style; both `VMT050_ALL` and direct `TMT050_NAME` joins exist, so do not normalize across families without approved scope.

Status:

- `preferred current pattern`: clause-by-clause `StringBuilder.append(...)`
- `tolerated legacy pattern`: older compressed inline SQL blocks that stay untouched
- `required migration pattern`: touched SQL blocks that already sit in a family or sibling set using the promoted `StringBuilder.append(...)` path

## Concrete Repository-Derived Rule: Null Or Empty Helper Reuse

Rule:

- Backend: prefer `ValidateUtility.isEmpty(...)` in new or touched code unless the named anchor family still intentionally standardizes `CheckNull(...)` for that exact flow.
- Frontend: prefer `Ultility.isEmpty(...)` or the touched family's established `ValidateUltility` wrapper instead of raw null or empty expressions.
- Do not introduce fresh open-coded null or empty checks when a shared helper already exists in the touched layer or family.

Status:

- `preferred current pattern`: backend `ValidateUtility.isEmpty(...)`, frontend `Ultility.isEmpty(...)` or family-owned `ValidateUltility`
- `tolerated legacy pattern`: backend `ValidateUtility.CheckNull(...)` in untouched anchored legacy helpers
- `required migration pattern`: touched scopes that already use the promoted helper for adjacent validation or sibling flows

## Concrete Repository-Derived Rule: Empty String Constants

Rule:

- Backend: reuse `ConstantValue.EMPTY_STRING` or an already-established family-owned empty-string constant.
- Frontend: reuse `Const.EMPTY_STRING` or an already-established family-owned empty-string constant.
- Do not introduce raw `""` in touched code when the layer or family already owns a named empty-string constant for that concern.

## Concrete Repository-Derived Rule: Magic Strings And Message Normalization

Rule:

- Scan shared constants and enum files before adding a new literal for codes, screen IDs, control IDs, column names, or message IDs.
- Reuse `ConstantMessageID` or `ConstMessageID` plus the shared message lookup flow for user-facing or validation messages.
- Do not introduce new raw English user-facing messages when the touched layer already resolves the same feedback through message IDs and shared lookup utilities.

## Concrete Repository-Derived Rule: Backend Validation, Shared Processes, And Error DTO Routing

Rule:

- Prefer the existing `AbstractKikanSystemProcess` lifecycle when the family already uses it: validation and guard work in `beforeProcessing(...)`, business work in `processing(...)`.
- Reuse `addErrorDto(...)`, `checkMsgSize(...)`, and `ProcessCheckErrorException` for accumulated validation failures when the family already uses that path.
- Reuse `ValidateUtility` length, date, and required-field helpers plus shared processes such as `MasterCodeCheckProcess` and `MasterNameGetProcess` before adding local validation SQL or helper clones.
- If the touched family already routes standard master-name lookup through `FocusOutGetNameProcess` or an equivalent shared request contract, do not introduce a feature-local replacement for the same concern.

Status:

- `preferred current pattern`: `beforeProcessing(...)` plus shared validation helpers and error DTO routing
- `tolerated legacy pattern`: older helper-local null checks or direct validation branches that remain untouched
- `required migration pattern`: touched validation or focus-out flows whose sibling anchors already use the shared backend process or helper

## Concrete Repository-Derived Rule: Frontend Field Validation And Error Routing

Rule:

- Prefer `BaseComponent.validateFields(...)` and the touched family's `ValidateUltility` configuration for required, format, date, and length validation when the screen family already supports them.
- Bind field-level errors through the existing message field or `Ultility.fnSetErrorMsg(...)`, and render them with `.inputError` directly below the related input, select, textarea, or date control.
- Reserve `notifyError` or popup-style errors for global blocking failures, modal outcomes, or shared fatal-error flows. Do not replace routine field-level validation with `notifyError` when sibling screens already keep those errors inline.
- When backend `fatalError.controlID` already maps to a field-level message path in the touched family, preserve that mapping instead of collapsing everything into a generic popup.

Status:

- `preferred current pattern`: `validateFields(...)` plus inline `.inputError` and message-id-driven field binding
- `tolerated legacy pattern`: older screens that still mix popup-heavy validation
- `required migration pattern`: touched screens whose siblings already use `validateFields(...)`, inline errors, or `Ultility.fnSetErrorMsg(...)` for the same concern

## Concrete Repository-Derived Rule: Frontend Focus-Out And Shared Validation Reuse

Rule:

- Prefer `BaseComponent` shared helpers, especially `fnFocusOutCommon(...)` and `validateFields(...)`, when the touched screen family already supports them.
- When the touched screen still owns a local wrapper such as `fnGetName(...)`, keep or improve the wrapper only when it remains the approved bridge to the shared focus-out contract.
- Do not add new direct `callWs(Const.focusOutGetNameWs, ...)` clones where the shared base-common path already covers the flow.

Status:

- `preferred current pattern`: `fnFocusOutCommon(...)` or the screen family's approved bridge to that shared request or response contract
- `tolerated legacy pattern`: direct local `fnGetName(...)` wrappers that already exist and still bridge to the shared focus-out contract
- `required migration pattern`: touched focus-out flows whose sibling anchors already support `fnFocusOutCommon(...)` or the common wrapper pattern

## Concrete Repository-Derived Rule: Frontend Table Column Configuration

Rule:

- Prefer `fnGetColumnTableConfig()` and the shared config-driven column path for touched tables when sibling anchors in the same family already support it.
- Use `BaseComponent.generateColumns()` when the family is already on the shared config-driven pattern.
- Do not extend manual `column['...']` assembly in touched table flows when the promoted config-driven pattern is already available to that screen family.

Status:

- `preferred current pattern`: `fnGetColumnTableConfig()` plus `generateColumns(...)`
- `tolerated legacy pattern`: manual `column['...']` assembly in untouched older screens
- `required migration pattern`: touched tables whose sibling anchors already expose the shared config-driven path

## Concrete Repository-Derived Rule: Frontend And Backend Validation Parity

Rule:

- Backend remains the final validation authority.
- When sibling flows already validate the same rule in both frontend and backend, new or changed behavior MUST check and update both layers or record an approved divergence.
- Do not close a feature, fix, or refactor as complete after backend-only validation when repository evidence shows the behavior family requires frontend validation too.

## Concrete Repository-Derived Rule: Frontend Responsive Layout And Paired-Field Alignment

Rule:

- When a touched screen includes forms, search conditions, result filters, or range fields, verify the layout against smaller window widths instead of only matching desktop appearance.
- Prefer the repository's live multi-breakpoint Bootstrap grid patterns, such as `col-12 col-sm-12 col-lg-*`, `col-auto` separators, and wrap-aware flex layouts, when sibling anchors already use them.
- Paired fields such as FROM-TO, date ranges, or code ranges must keep the label, separator, both inputs, and inline error blocks aligned or intentionally stacked without overlap, clipping, or order confusion on smaller windows.
- Do not extend desktop-only `col-md-*` range splits in touched forms when sibling anchors in the same family already provide a more responsive pattern.

Status:

- `preferred current pattern`: multi-breakpoint grid and wrap-aware layouts used by newer screens and shared range-field templates
- `tolerated legacy pattern`: older desktop-heavy `col-md-*` layouts that stay untouched
- `required migration pattern`: touched range rows or form sections whose sibling anchors already support the promoted responsive layout path

## Concrete Repository-Derived Rule: Comment Language And Comment Minimization

Rule:

- New or rewritten code comments and Javadoc must be English-only.
- Existing untouched Japanese or mixed-language comments are tolerated legacy and do not require mass rewrite.
- When a touched comment needs correction or the surrounding logic is being meaningfully changed, rewrite that comment in English instead of leaving mixed-language content.
- Prefer self-explanatory code and shared naming over narrator comments; add comments only for non-obvious behavior, guard logic, compatibility, or contract-sensitive flow.

Status:

- `preferred current pattern`: minimal English-only comments on non-obvious logic
- `tolerated legacy pattern`: untouched older Japanese or mixed-language comments
- `required migration pattern`: any newly added comment or any existing comment that is being rewritten in the touched scope

## Concrete Repository-Derived Rule: Search Screen Init, Count, List, And Saved-Condition Lifecycle

Rule:

- When a search screen family already depends on init data such as dropdown lists, store lists, or KBN lists, load that init data before calling `loadSearchConditions()`.
- Search flows usually clear current notifications or stale field errors, validate current inputs, snapshot or save conditions, call the count endpoint first, then call the list endpoint only when count is non-zero.
- When the screen family already uses `SearchConditionManagementService`, keep saved-condition load or save on that shared service rather than introducing a feature-local alternative.
- Zero-result paths should clear table and pager state and route through the standard info or no-data handling of the touched family.
- When a result header already uses record count on the left and `wms-page` on the right, preserve that structure for behavior-only changes.

Status:

- `preferred current pattern`: init-data-first hydration plus count-then-list plus shared saved-condition management where the family already uses it
- `tolerated legacy pattern`: older screens without saved-condition support or with manual column setup that remain untouched
- `required migration pattern`: touched search screens whose sibling anchors already use the shared lifecycle and saved-condition service

## Concrete Repository-Derived Rule: Silent Error Swallowing Is Legacy Only

Rule:

- Empty `.catch(() => {})` blocks and similar swallowed frontend transport errors exist in older screens, but they are tolerated legacy only.
- Do not add new silent catch blocks to user-visible flows. Reuse the shared error-routing path or record the explicit surrounding owner for the error.

## Concrete Repository-Derived Rule: Java SQL Bind Counters

Evidence sources:

- `docs/sdd/standards/database-change-rules.md`
- `docs/sdd/context/code-structure-rules.md`
- `docs/sdd/governance/10-code-standards.md`

Rule:

- For Java SQL flows that build queries with `StringBuilder` and bind parameters across branches, loops, batch binds, or helper calls, prefer `AtomicInteger`.
- Do not introduce fresh `int index++` chains in new or touched mutable bind flows.
- Untouched legacy families that already use a different bind-counter style may stay unchanged unless the approved scope includes that cleanup.

## Gate

If repository evidence for a proposed auto-rule is not visible, do not add the rule.

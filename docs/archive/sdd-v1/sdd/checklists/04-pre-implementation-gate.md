# Pre-Implementation Gate Checklist

## When To Use

Use this checklist immediately before the first implementation commit.

## How To Use

Review the feature package first, then confirm the named anchors, relevant tests, and owned contracts or schema files have been inspected before implementation starts.

## Required Output

- pass or fail decision for implementation start
- list of missing artifacts or blockers when the gate fails
- list of inspected code, contract, or test references when the gate passes

## Gate

Coding starts only when all applicable items are checked.

- [ ] `07-tasks.md` contains `TASK-` items linked to requirements or design.
- [ ] `08-acceptance-criteria.md` contains `AC-` items linked to requirements.
- [ ] `09-test-cases.md` contains `TC-` items linked to acceptance criteria.
- [ ] `10-rollout.md` contains deployment steps and rollback steps.
- [ ] The traceability table in `README.md` has at least one populated row.
- [ ] Any conditionally required spec files are present or marked `n/a` in `README.md`.
- [ ] `02-design.md` lists source-base anchor files for each touched layer (frontend `.ts/.html`, backend process/webservice, SQL assembly path when applicable).
- [ ] The `Source Base Anchors` block in `02-design.md` uses the fixed labels and each label has a value or `n/a`.
- [ ] `02-design.md` states whether new tables, source families, or screen structure are in scope; the default remains `no` unless the spec explicitly opens that scope.
- [ ] The implementation plan identifies the related module family, sibling flows, and existing code references that were inspected before write.
- [ ] The implementation plan identifies the shared backend processes or helpers and the shared frontend base or common helpers inspected for the touched concerns.
- [ ] The implementation plan records the local code-shape constraints that must be preserved for the touched family, such as DTO style, transport path, prepared-statement index style, import boundaries, and comment or formatting style.
- [ ] The implementation plan records touched-file cleanup work for unused imports, redundant code, and any necessary comment rewrites in the touched scope.
- [ ] The implementation plan identifies the shared helpers, constants, message catalogs, base-common flows, table helpers, and validation-parity rules that must be reused or modernized within the touched scope.
- [ ] The implementation plan records mixed-pattern classification and any required migration or grounded exception for touched validation, focus-out, table, search-lifecycle, or backend process concerns.
- [ ] If SonarQube or static-analysis findings drive the task, the finding source or triage artifact was inspected before write and each no-fix status boundary is explicit.
- [ ] If SonarQube or static-analysis findings drive the task, the implementation plan records how non-fixed findings will be classified and updated in the triage artifact.
- [ ] The implementation plan records field-level versus popup error-routing expectations for touched frontend validation or fatal-error flows.
- [ ] The implementation plan records frontend structure reuse, responsive layout verification, and paired-field alignment checks when frontend screens or forms are touched.
- [ ] Existing tests for the touched area were inspected and the expected verification path is clear.
- [ ] Owned contracts, schema files, or locked prose contract artifacts were inspected when the change touches interfaces or durable data.
- [ ] Reuse-before-create was evaluated for new routes, modules, classes, interfaces, tables, fields, and components.
- [ ] Any ambiguity or conflict between spec, code, tests, schema, or standards is explicitly recorded as a blocker instead of being left to implementation-time guessing.
- [ ] Any proposed new API, route, table, field, module, class, interface, or environment variable is explicitly authorized by the approved artifacts or grounded in existing code.
- [ ] If the feature changes a meaningful API or durable data contract, `contracts/` is present or the reason for not adding it is explicit in the spec.
- [ ] If `Task Profile: sonar-fix-from-triage` is in scope, only `approved-fix` items are planned for code changes in the current pass.
- [ ] If the feature owns `spec-pack.manifest.yaml`, the manifest is present and the spec-pack can be built and validated.
- [ ] Blocking open questions are resolved or explicitly marked as blockers.
- [ ] The minimum `REQ -> DES -> TASK -> AC -> TC` chain is visible without guessing.
- [ ] A reviewer can explain what will be built from the spec package and inspected anchor evidence without guessing missing behavior.

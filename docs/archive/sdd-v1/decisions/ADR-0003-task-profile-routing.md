# ADR-0003 Task-Profile Routing For Agent Work

- Status: accepted
- Date: 2026-03-13
- Owners: repository maintainers
- Related specs: `docs/specs/2026-03-13-task-profile-routing/`

## Context

The repository already defines canonical specs, standards, and generated spec-packs, but agent requests still arrive in several operational shapes:

- implement a new feature from canonical specs
- fix code from a generated spec-pack
- fix code from a bug description without a generated pack
- review code against a generated spec-pack
- review code against repository rules without a generated pack

Without an explicit routing contract, agents can over-rely on prompt wording and inconsistently decide which markdown files to load. That creates drift between implementation, review, and governance expectations.

The repository also needs to support backend-focused helper notes such as `spec_back.md` without turning them into a new approval source of truth.

## Decision

This repository adopts task-profile routing for agent work.

1. Agent requests may declare a canonical `Task Profile` header to select the loading matrix for the job.
2. The supported task profiles are:
   - `implement-new`
   - `fix-from-pack`
   - `fix-from-bug`
   - `review-from-pack`
   - `review-from-rules`
3. Task profiles route which markdown artifacts are loaded, but they do not override governance classification or the requirement for a governing feature package on non-trivial work.
4. `docs/specs/<feature-id>/` remains the approval source of truth. `docs/spec-packs/<feature-id>.pack.md` remains an execution aid.
5. `spec_back.md` or similar backend helper notes are allowed only as helper inputs. They map to the backend-facing subset of the governing feature package and never replace it.

## Consequences

- Agents gain one stable way to choose the right markdown set for implementation, fixing, and review work.
- `fix-from-bug` requests still require a reduced-path or full-path feature package before non-trivial code changes begin.
- `review-from-rules` may omit a spec-pack, but it does not permit skipping the governing feature package for governed work.
- Prompt headers become part of the operational contract and should stay compact, explicit, and stable.

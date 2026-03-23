# Spec Pack: 2026-03-23-project-technical-profile-audit - Repository Technical Profile Audit

- Status: approved
- Owner: AI audit task
- Last Updated: 2026-03-23

## 1. Context

- The repository request is an audit-only task over the project's actual technical shape, not a style review.
- The audit must determine the real project type, runtime architecture, frontend and backend stack, routing, state, data access, form handling, UI layer, testing reality, observability surface, and business-domain signals.
- Conclusions must be grounded in code, build configuration, deploy configuration, test setup, and representative runtime codepaths rather than dependency presence alone.

## 2. Scope

### In Scope

- inspect root build and deploy surface, including Maven, Ant, web resources, and Java entry wiring
- inspect the active frontend under `src/main/webapp/angular`
- inspect representative backend API packages under `src/main/java/jp/co/brycen/kikancen`
- inspect test setup under both `src/main/webapp/angular` and `src/test/java`
- record mixed, legacy, and transitional patterns explicitly
- leave a durable `audit.md` trace for this repository-level profile audit

### Out Of Scope

- changing runtime code, contracts, or schemas
- speculative product requirements not grounded in repository evidence
- performance, security, or code-style review beyond what is necessary to classify technical shape

## 3. Functional Requirements

### FR-01 Architecture Conclusions Are Evidence-Backed

- every project-profile conclusion must map to concrete files, bootstrap points, or active codepaths
- installed but unused libraries must be classified as secondary, legacy, or unresolved rather than primary

### FR-02 Mixed Runtime Patterns Are Classified

- if multiple patterns coexist, the audit must separate primary, secondary, and legacy or transitional patterns

### FR-03 Testing Reality Reflects What Is Runnable

- the audit must distinguish configured test stacks from test stacks that appear runnable in the current repository state

### FR-04 Review Guidance Matches The Actual Repo

- the audit must recommend future review focus based on the real coupling surface and blast radius, not on generic framework checklists

## 4. Technical Shape

### Source Anchors

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `pom.xml`
- `build.xml`
- `src/main/webapp/WEB-INF/web.xml`
- `src/main/java/jp/co/brycen/common/config/ApplicationConfig.java`
- `src/main/java/jp/co/brycen/common/webservice/AbstractAPIWebService.java`
- `src/main/java/jp/co/brycen/kikancen/`
- `src/main/webapp/angular/`
- `src/test/java/`

## 5. Decisions And Constraints

- treat the repository as a single deployed system unless stronger conflicting evidence appears
- prefer entrypoints, servlet wiring, module wiring, route definitions, templates, and service calls over dependency installation
- keep unknowns explicit where deploy-time packaging or dormant libraries cannot be confirmed from source

## 6. Acceptance Criteria

- the audit identifies the actual deployable shape and primary runtime bootstrap for both backend and frontend
- the audit distinguishes active frontend patterns from installed-but-unproven libraries
- the audit records testing and observability evidence, including concrete setup gaps
- the audit leaves `audit.md` in this feature-pack home before closeout

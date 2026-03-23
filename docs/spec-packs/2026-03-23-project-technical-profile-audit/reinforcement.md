# Reinforcement: 2026-03-23-project-technical-profile-audit

- Status: active
- Last Updated: 2026-03-23

## 1. Audit Guardrails

- do not infer modern frontend patterns unless code shows they are active
- do not treat dependency presence as runtime usage
- do not flatten mixed frontend and backend patterns into a single generic label
- call out legacy or transitional tooling when build or deploy surfaces disagree

## 2. Evidence Discipline

- validate conclusions from bootstrap files first, then shared services, then representative screens and backend modules
- use representative module samples to identify repeated structural patterns
- if a runtime behavior cannot be proven from source or checked-in build output, mark it unresolved

## 3. Review Framing

- keep this artifact focused on technical shape, blast radius, and future review implications
- avoid style findings or refactor suggestions unless they materially affect architecture classification

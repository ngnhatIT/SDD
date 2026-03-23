# Testing Rules

- `verification.md` must map evidence back to acceptance criteria in `spec_pack.md`.
- Use the strongest practical evidence for the real risk. Automated tests are preferred when available.
- Manual verification is allowed when automation is absent, but it must be stated explicitly.
- Do not claim coverage, validation, or runtime proof that was not actually performed.
- Review regression risk across sibling flows, not only the edited line.
- If acceptance coverage is partial, record the gap as unresolved rather than implying completion.

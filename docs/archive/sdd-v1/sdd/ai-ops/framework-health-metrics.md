# Framework Health Metrics

## When To Use

Use this helper when maintainers want lightweight signals about whether SDD is improving delivery speed, proof coverage, rework, and safety without losing governance discipline.

## How To Use

1. Choose a small review window such as the last 10 governed tasks or a rolling monthly check.
2. Read the existing feature packages, implementation reports, review reports, triage artifacts, rollout notes, and incident or bug follow-up notes already produced by normal work.
3. Tally only the signals that actually occurred.
4. Treat the results as directional operating signals, not as merge gates or team scorecards.

## Required Output

- a short set of counts or trend notes derived from existing task artifacts
- one concrete follow-up when a signal clearly trends the wrong way

## Gate

This document is helper-only. It informs framework maintenance and operator coaching; it does not replace governance or create a new approval workflow.

## Lightweight Recording Rules

- Record signals from existing artifacts first: `README.md`, `07-tasks.md`, `09-test-cases.md`, `10-rollout.md`, `11-implementation-report.md`, `12-review-report.md`, `docs/sonar/`, and approved bug or incident notes when they exist.
- Do not create a new mandatory per-task metrics file.
- Count only grounded events that are visible in repository artifacts or approved review notes.
- Zero counts do not require a placeholder record.
- If a signal blocks a live task, record it in the current feature artifacts before counting it in a framework review.

## Metric Catalog

| Metric | What It Means | Why It Matters | How To Record Lightly | Trend That Signals A Process Problem |
| --- | --- | --- | --- | --- |
| `spec-ready to review-ready lead time` | The elapsed time from a grounded spec or approved request being ready to the task reaching review-ready. | Shows whether the framework is helping delivery move faster without skipping controls. | Use feature status changes, report dates, or PR timestamps when available; note gaps instead of guessing. | Similar-sized work consistently taking longer without a clear risk or scope explanation. |
| `review reopen count` | A task was considered review-ready or passed review, then reopened because blocking evidence or findings were missed. | Reopens usually mean the completion bar, self-review depth, or spec grounding was too weak. | Count cases where `12-review-report.md` or follow-up review notes move from `pass` or `pass with notes` back to a blocking state. | More than one reopen in 10 governed tasks, or repeated reopens in the same feature family. |
| `test evidence coverage rate` | The share of in-scope `AC-` items that have recorded `TC-` results and a named proof strategy. | Shows whether SDD is producing proof, not just prose and code. | Count visible `AC -> TC -> result` mappings in the governing package and reports. | Repeated tasks claiming completion while `TC-` results or proof strategy notes are missing. |
| `manual-only high-risk change count` | Higher-risk work closed with manual-only proof and no strong reason automation was impractical. | Highlights where safety expectations are slipping or where tooling gaps need attention. | Count high-risk or full-path tasks whose evidence is manual-only and whose reports lack a convincing rationale or backfill note. | Repeated high-risk manual-only closures with vague justification. |
| `defect escape or regression count` | A released change caused a post-release defect, regression, or repeated hotfix on the same surface. | Measures whether faster delivery is still safe. | Count incident or bug follow-up notes linked back to the prior feature or hotfix. | Repeated regressions on recently changed surfaces or recurring hotfixes after supposed stabilization. |
| `triage-before-fix rate` | The share of SonarQube, QA, review, bug, or production findings that were explicitly triaged before code changed. | Triage-first prevents blind fixes and wrong-scope work. | Count findings with visible triage, applicability confirmation, or approved finding status before the implementation report shows changes. | Findings regularly fixed directly from raw scanner output, review comments, or bug text without current-state confirmation. |
| `feedback backfill lag` | Deferred spec, proof, or incident follow-up remains open after a hotfix or compact finding-driven change. | Shows whether the framework is learning from urgent work or leaving permanent gaps. | Count backfill notes in rollout, implementation, or incident artifacts and track whether they were later closed. | Backfill notes staying open across multiple review windows or repeated emergency work on the same surface. |
| `hallucination finding count` | Formal review confirmed invented behavior, fields, APIs, modules, or unsupported claims. | This is a direct anti-hallucination quality signal. | Count non-empty confirmed hallucination entries or hallucination-tagged findings in `12-review-report.md`. | Any recurring count across consecutive reviews, or any spike concentrated in one path or prompt. |
| `spec or contract drift count` | The governing package, generated aid, and implemented or reviewed scope drifted out of sync. | Drift undermines approval fidelity and makes later work more expensive. | Count findings or conflict notes that explicitly call out spec, test, or contract drift. | Rising drift over two review windows, especially on reduced-path work that should stay compact. |
| `missing-artifact blocker count` | Work stalled because a required artifact was missing, stale, or ambiguous. | Repeated blockers point to weak intake, design completeness, or poor routing discipline. | Count blocker notes in `11-implementation-report.md`, `12-review-report.md`, or recovery notes that cite missing required artifacts. | Repeated blockers in the same stage or feature type, or more than two in a short review window. |
| `task-profile or mode reclassification count` | The original task profile or practical mode had to be corrected after work started. | Reclassification is a routing-quality signal. | Count explicit reclassification notes in implementation reports, review reports, or recovery notes. | More than a small minority of tasks being reclassified, or repeated confusion between the same two paths. |
| `average artifacts touched per task` | The average number of canonical artifacts updated for a governed task. | Shows whether reduced-path work stays small or whether the framework is becoming too fragmented to operate efficiently. | Count the numbered feature artifacts and canonical framework docs actually updated per task, then average by sample window. | Reduced-path work regularly touching many artifacts, or a sharp increase after a framework change. |

## Using The Signals

- Look for repeated direction, not isolated noise.
- Prefer a small corrective action such as clarifying one rule, guide, or template over broad framework churn.
- When a signal clearly maps to one canonical layer, fix that layer instead of adding a second explanation somewhere else.
- If a signal cannot be recorded from existing artifacts without guesswork, tighten the current artifact guidance before inventing a new measurement surface.

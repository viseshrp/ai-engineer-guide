# Offline Product Feature Spec

## Feature

Generate a valid report template from selected existing report items.

## User Value

Users already have report items and metadata. The hard part is arranging them into a useful, valid report structure. The feature should propose a starting template that users can inspect and edit.

## Non-Goals

- Do not generate scientific claims.
- Do not invent report data.
- Do not call hosted model APIs.
- Do not download models at runtime.
- Do not send metadata outside the local environment.
- Do not persist unvalidated model output.

## Inputs

- Selected report item ids
- Report item titles
- Report item types
- Existing tags or categories
- Optional section hints
- Optional ordering hints

## Output

A constrained `Template AST` containing:

- sections
- section titles
- item references
- allowed layout choices
- ordering
- explanation metadata for audit/debugging

## Required System Parts

- metadata extraction
- retrieval/ranking
- deterministic baseline
- local model proposal
- schema validation
- product-rule validation
- normalization
- deterministic fallback
- evaluation runner
- feature flag
- local model artifact configuration

## Success Metrics

- valid JSON rate
- schema pass rate
- product-rule pass rate
- fallback rate
- human edit distance
- latency
- model artifact size
- memory footprint

## Failure Policy

Fail closed.

If retrieval, model inference, parsing, validation, or normalization fails, the system should return a deterministic baseline template or no proposal. It should never persist invalid output.

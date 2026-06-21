# AI Engineer Guide

This repo is a personal study and planning workspace for becoming an AI engineer from a lead full-stack engineering background.

The target is not generic ML research or model training. The long-term target is applied AI systems engineering: building, shipping, evaluating, and operating AI-powered product features inside real software products across domains.

## Current Direction

The long-term lane from the exported roadmap is:

> Lead full-stack/software engineer becoming an AI engineer who can design and ship useful AI-powered product features across domains.

The current starting point is narrower: local-first, on-prem, air-gapped AI features for enterprise/scientific reporting software. That is the practical first domain because it matches the software currently available to build on. The skills should transfer later to non-scientific and non-engineering products.

This repo should build on:

- Python, Django, JavaScript, Postgres, APIs, and production web systems
- Complex enterprise/scientific reporting workflows
- Secure and on-prem deployments
- CI/CD, observability, permissions, and operational tradeoffs
- Information retrieval, RAG, embeddings, structured outputs, and evaluation

## Product Anchor

The first concrete product use case, based on the current available product domain, is scientific reporting template auto-generation:

> Generate a report template from selected existing report items using only local metadata, deterministic rules, and an offline permissively licensed model.

This is intentionally bounded:

- No cloud inference
- No SaaS dependency
- No runtime downloads
- No outbound network calls
- Disabled by default behind a beta/config flag
- Model artifacts are pinned, hash-verified, and locally configured
- AI proposes structure; product rules validate and enforce correctness

## First Feature Thesis

Template auto-generation is the first implementation target because it is high-value and relatively low-risk.

Users already have the report items. The hard part is building a complex, valid report structure from scratch. The AI layer should infer grouping, ordering, section titles, and layout choices from existing metadata, while deterministic product rules guarantee template validity.

The model should output a constrained Template AST, not HTML or free-form report content.

Example conceptual flow:

```text
Selected report items
  -> metadata extraction
  -> deterministic hard constraints
  -> local instruction-tuned model proposes Template AST
  -> JSON schema validation
  -> rule-based normalization
  -> existing template persistence
```

## Model Constraints

Candidate models should be evaluated only if they satisfy the deployment and licensing constraints:

- Permissive license suitable for commercial redistribution: Apache-2.0, MIT, or BSD-style
- Fully offline Python inference
- English-only is sufficient for now
- Bundled or mirrored internally as static artifacts
- No unclear custom, research-only, or non-commercial licenses

The first implementation should favor the smallest model that reliably emits valid constrained JSON for the Template AST schema. Larger models are acceptable only if evaluation shows a clear quality gain worth the installer-size cost.

## Roadmap

1. Define the Template AST schema.
2. Define hard product constraints the model is forbidden to violate.
3. Build a deterministic baseline generator.
4. Evaluate small permissively licensed instruction-tuned models against the baseline.
5. Add JSON/schema validation, normalization, and deterministic fallback.
6. Write evaluation fixtures from realistic report-item metadata.
7. Document deployment, licensing, model provenance, and security posture.
8. Convert the finished work into resume/interview evidence for applied AI systems engineering.

## Source Material

- [AI_ENGINEER_ROADMAP_CHAT.md](./AI_ENGINEER_ROADMAP_CHAT.md) contains the full exported ChatGPT planning conversation that seeded this repo.
- [STUDY_RESOURCES.md](./STUDY_RESOURCES.md) ranks external study resources against the current short-term and long-term AI engineering goals.
- [OFFLINE_STUDY_GUIDE.md](./OFFLINE_STUDY_GUIDE.md) is the default end-to-end, local-only study path.
- [external-curriculum/](./external-curriculum/) contains curated offline slices of external courses, with source metadata in [external-curriculum/SOURCES.md](./external-curriculum/SOURCES.md).
- [docs/CURRICULUM_MAINTENANCE.md](./docs/CURRICULUM_MAINTENANCE.md) explains how to refresh the curated curriculum without reintroducing provider-specific material.

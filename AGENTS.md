# AGENTS.md

## Purpose

This repo is a personal AI-engineering study and implementation guide. Treat it as a working plan for a lead full-stack engineer transitioning into applied AI systems engineering: building, shipping, evaluating, and operating AI-powered product features in real software products across domains.

The current short-term focus is local-first, on-prem, air-gapped AI features for enterprise/scientific reporting software because that is the practical product context currently available. Do not treat that domain as the permanent ceiling. Future work should preserve transferable AI-engineering skills that can apply to non-scientific and non-engineering products too.

Do not steer the repo toward generic ML research, model training, or toy chatbot demos unless explicitly requested. The most important direction is production AI systems: RAG, information retrieval, structured outputs, model evaluation, offline inference, deterministic guardrails, deployment constraints, and product integration.

## Primary Product Thread

The first concrete product use case, based on the current available product domain, is AI-assisted template auto-generation for a scientific reporting platform.

Core feature framing:

> Generate a valid report template from selected existing report items using only local structured metadata, deterministic product rules, and an offline permissively licensed model.

Preserve these constraints in future work:

- No outbound network calls from the product feature.
- No SaaS model APIs.
- No runtime model downloads.
- Offline/local inference only.
- The feature is optional and disabled by default.
- Model artifacts must be pinned, hash-verified, and configured by local path.
- AI output is advisory and must be validated before persistence.
- The product rule layer owns correctness.

## Architecture Bias

Prefer bounded, auditable systems over open-ended agents.

Recommended shape:

```text
Input metadata
  -> deterministic constraints
  -> local model proposes Template AST
  -> schema validation
  -> rule-based normalization
  -> deterministic fallback if invalid
  -> existing template persistence
```

The model should not invent scientific content, make physics claims, inspect private source code, or silently publish results. It may propose grouping, ordering, layout choices from an allowed set, and short section titles.

## Model And License Policy

Only consider models with licenses that allow commercial use and redistribution in a proprietary product. Prefer:

- Apache-2.0
- MIT
- BSD-style licenses

Avoid:

- non-commercial licenses
- research-only licenses
- unclear custom licenses
- licenses with field-of-use restrictions or revocation ambiguity
- models that phone home or require online services

When researching models, record:

- model name and source
- exact version or commit
- license and link to license text
- artifact size
- expected runtime path in Python
- offline inference requirements
- JSON/structured-output behavior
- known risks

## Documentation Style

Keep documentation pragmatic and implementation-oriented. Prefer checklists, decision records, schemas, eval plans, and product/security design notes over broad motivational content.

When adding new docs, link them from `README.md`.

Use this source file as the context seed:

- `OFFLINE_STUDY_GUIDE.md` is the default execution path.
- `external-curriculum/` contains curated source material. Do not add full upstream repositories, translations, generated quiz apps, hosted-provider labs, or cloud-only samples.
- Run `scripts/check_offline_curriculum.sh` after changing curriculum docs or imported resource folders.

- `AI_ENGINEER_ROADMAP_CHAT.md`

## Near-Term Work Items

Good next tasks for agents:

- Draft the Template AST JSON schema.
- Define hard validation rules for generated templates.
- Create a model evaluation checklist for template-generation candidates.
- Build a comparison table of permissively licensed instruction-tuned models.
- Draft an air-gapped deployment/security review note.
- Turn the work into resume bullets and interview narratives for applied AI systems roles.

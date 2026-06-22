# Offline AI Engineering Study Guide

This is the default study path for this repo.

Goal: become an applied AI engineer who can build useful AI-powered product features in real software products, starting with local-first and on-prem features because that is the current practical product context.

Constraint: every default exercise must work without hosted model APIs, hosted embedding APIs, runtime downloads, or outbound network calls.

## Operating Rules

- Use local files, local databases, local search indexes, and local model runtimes.
- Treat upstream course material as reference, not as commands to run verbatim.
- Replace hosted model calls with local inference.
- Replace hosted embeddings with local embedding models.
- Replace public-data ingestion with checked-in fixtures or locally mirrored datasets.
- Prefer bounded workflows over open-ended agents.
- Validate model output with schemas and deterministic product rules before persistence.
- Keep every project small enough to explain in a design doc and demo offline.

## Local Runtime Assumptions

The guide is provider-neutral. Any local runtime can be used if it works offline:

- `llama.cpp`
- Ollama with preloaded local models
- Hugging Face Transformers using local model files
- ONNX Runtime with local artifacts
- a deterministic fake model for tests

Do not make the guide depend on a specific hosted provider.

## Study Outcome

By the end, this repo should contain:

1. A local RAG/search prototype over report-item metadata.
2. A deterministic baseline generator for report templates.
3. A local-model template proposal path.
4. JSON schema validation and rule-based normalization.
5. Evaluation fixtures and metrics.
6. A product/security design note for offline deployment.
7. A portfolio-ready writeup explaining tradeoffs, limitations, and next steps.

## Phase 0: Orientation

Purpose: understand the target and avoid wandering into generic ML.

Read:

- [README.md](./README.md)
- [STUDY_RESOURCES.md](./STUDY_RESOURCES.md)
- [external-curriculum/SOURCES.md](./external-curriculum/SOURCES.md)

Deliverables:

- Write a one-page problem statement for the first feature.
- Define the target user, input data, output object, and non-goals.
- State why the system must work offline.

Exit criteria:

- The feature is framed as a product workflow, not a chatbot.
- The output is a structured object, not free-form generated content.

## Phase 1: GenAI Product Basics

Purpose: learn the application concepts without adopting cloud provider code.

Read:

- `external-curriculum/generative-ai-for-beginners/05-advanced-prompts`
- `external-curriculum/generative-ai-for-beginners/12-designing-ux-for-ai-applications`
- `external-curriculum/ai-engineering-from-scratch/phases/08-generative-ai`
- `external-curriculum/ai-engineering-from-scratch/phases/11-llm-engineering`

Build:

- A local prompt harness that accepts a report-item metadata fixture and returns a proposed `Template AST`.
- A deterministic fake-model mode for tests.

Deliverables:

- `docs/TEMPLATE_AST_SCHEMA.md`
- `docs/PROMPT_CONTRACT.md`
- `tests/fixtures/report_items/*.json`

Exit criteria:

- The prompt contract states exact input fields, allowed output fields, and forbidden behavior.
- Tests can run without a real model.

## Phase 2: Search And Retrieval Foundations

Purpose: learn retrieval before adding generation.

Read:

- `external-curriculum/rag-tutorial/README.md`
- `external-curriculum/rag-tutorial/CHEATSHEET.md`
- `external-curriculum/rag-tutorial-source/python_tutorial.py`
- `external-curriculum/production-rag/static`
- `external-curriculum/ai-engineering-from-scratch/phases/05-nlp-foundations-to-advanced`

Build:

- Run the PyCon tutorial mentally or locally against already-downloaded assets.
- Replace the sample document corpus with product-style report-item fixtures.
- Build a local index over report-item metadata.
- Keyword search first.
- Local embedding search second.
- Hybrid ranking only after keyword search works.

Offline substitutions:

- Replace public paper ingestion with checked-in report-item fixtures.
- Replace hosted embeddings with local sentence-transformer, ONNX, or deterministic embedding stub.
- Replace external PDFs with local fixture text.

Deliverables:

- `docs/RAG_TUTORIAL_PRODUCTIZATION.md`
- `docs/RETRIEVAL_DESIGN.md`
- `src/retrieval/`
- `tests/retrieval/`

Exit criteria:

- Given a report-item fixture set, the system can retrieve relevant items deterministically.
- Retrieval quality can be scored against hand-written expected results.

## Phase 3: Structured Output And Guardrails

Purpose: make model output safe enough for product integration.

Read:

- `external-curriculum/ai-engineering-from-scratch/phases/11-llm-engineering`
- `external-curriculum/ai-engineering-from-scratch/phases/13-tools-and-protocols`

Build:

- A `Template AST` JSON schema.
- A validator that rejects unknown fields, invalid nesting, invalid item references, and unsupported layout choices.
- A normalizer that repairs safe formatting issues but rejects semantic violations.
- A deterministic fallback generator.

Deliverables:

- `src/template_ast/`
- `docs/VALIDATION_RULES.md`
- `tests/template_ast/`

Exit criteria:

- Invalid model output never reaches persistence.
- The fallback path produces a valid template without model inference.

## Phase 4: Local Model Evaluation

Purpose: choose the smallest local model that does the job reliably.

Read:

- `external-curriculum/ai-engineering-from-scratch/phases/08-generative-ai`
- `external-curriculum/ai-engineering-from-scratch/phases/11-llm-engineering`
- selected model/runtime material from `external-curriculum/ai-engineering-from-scratch/phases/17-infrastructure-and-production`

Build:

- A model adapter interface.
- Local runtime adapters as needed.
- A fixture-driven evaluation runner.
- Metrics for valid JSON rate, schema pass rate, rule pass rate, edit distance from expected structure, latency, and fallback rate.

Deliverables:

- `docs/MODEL_SELECTION.md`
- `docs/EVALUATION_PLAN.md`
- `evals/`

Exit criteria:

- Model choice is based on measured behavior, not preference.
- Results include installer-size and runtime tradeoffs.

## Phase 5: MCP And Tool Boundaries

Purpose: learn tool boundaries without turning the feature into an unconstrained agent.

Read:

- `external-curriculum/mcp-for-beginners/00-Introduction`
- `external-curriculum/mcp-for-beginners/03-GettingStarted/02-client`
- `external-curriculum/mcp-for-beginners/03-GettingStarted/05-stdio-server`
- `external-curriculum/mcp-for-beginners/03-GettingStarted/08-testing`
- `external-curriculum/mcp-for-beginners/04-PracticalImplementation`
- `external-curriculum/ai-engineering-from-scratch/phases/13-tools-and-protocols`

Build:

- A local-only tool boundary for reading allowed report metadata.
- A local-only tool boundary for validating a proposed template.
- Tests proving tools cannot access arbitrary files or network resources.

Deliverables:

- `docs/TOOL_BOUNDARIES.md`
- `src/tools/`
- `tests/tools/`

Exit criteria:

- The model can request only explicitly exposed tools.
- Tools are deterministic, logged, and permission-scoped.

## Phase 6: Agent Concepts, Used Sparingly

Purpose: understand agent patterns without overengineering the first feature.

Read:

- `external-curriculum/generative-ai-for-beginners/17-ai-agents`
- `external-curriculum/ai-engineering-from-scratch/phases/14-agent-engineering`
- `external-curriculum/ai-engineering-from-scratch/phases/13-tools-and-protocols`

Build:

- A bounded planner that can choose between retrieval, deterministic baseline, local-model proposal, validation, normalization, and fallback.
- No autonomous external actions.
- No multi-agent architecture unless a concrete product need appears.

Deliverables:

- `docs/WORKFLOW_ORCHESTRATION.md`
- `src/workflows/`
- `tests/workflows/`

Exit criteria:

- The workflow is inspectable as a state machine.
- Every state has deterministic error handling.

## Phase 7: Offline Productization

Purpose: make the prototype feel like a shippable product feature.

Read:

- `external-curriculum/ai-engineering-from-scratch/phases/17-infrastructure-and-production`
- local notes created in this repo

Build:

- Feature flag/config toggle.
- Local model path configuration.
- Hash verification for model artifacts.
- No-runtime-download enforcement.
- Structured logs for generation attempts, validation failures, fallbacks, and latency.
- Offline installation notes.

Deliverables:

- `docs/OFFLINE_DEPLOYMENT.md`
- `docs/SECURITY_AND_PRIVACY.md`
- `docs/OBSERVABILITY.md`

Exit criteria:

- The feature can be explained to a security reviewer.
- The feature can fail closed without blocking the existing product workflow.

## Phase 8: Portfolio Packaging

Purpose: convert the work into credible AI engineering evidence.

Build:

- A short demo script.
- A design doc.
- An evaluation report.
- A resume/interview narrative.

Deliverables:

- `docs/DEMO_SCRIPT.md`
- `docs/DESIGN_DOC.md`
- `docs/EVALUATION_REPORT.md`
- `docs/PORTFOLIO_NOTES.md`

Exit criteria:

- You can explain the problem, architecture, constraints, evaluation, failures, and tradeoffs in 5 minutes.
- The work is transferable beyond scientific/reporting software.

## Reference-Only Foundations

Use these only when blocked by a concept gap:

- `external-curriculum/ml-for-beginners`
- `external-curriculum/ai-for-beginners`
- `external-curriculum/data-science-for-beginners`

Recommended lookup path:

- Metrics or model evaluation gap: `ml-for-beginners`
- Embeddings/transformers gap: `ai-for-beginners`
- Data cleanup/statistics gap: `data-science-for-beginners`

Do not complete these courses linearly before building.

## Definition Of Done

The offline study guide is complete when:

- No default task requires network access.
- No default task requires a hosted model API.
- No default task requires a cloud service.
- Every model output is validated before use.
- Every important result is reproducible from local fixtures.
- The final artifact is a product feature prototype, not a notebook-only demo.

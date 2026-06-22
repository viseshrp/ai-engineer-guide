# RAG Tutorial Productization Plan

## Verdict

`viseshrp/rag-tutorial` fits this repo well.

It is more directly useful than most broad beginner curricula because it starts with the exact system shape this roadmap needs: document ingestion, chunking, embeddings, similarity retrieval, prompt assembly, and local generation. It is currently tutorial/notebook-shaped, but that is useful as a learning seed. The next step is to turn it into a product-grade offline retrieval component.

## Imported Sources

- Wrapper repo: `external-curriculum/rag-tutorial`
- Original upstream tutorial content: `external-curriculum/rag-tutorial-source`
- Wrapper commit: `313427d1d56b2d7fb80b9ed2d6fb588814869931`
- Upstream tutorial commit: `ae908ee8a61dc1723f5386538bf2a1266c4cf0df`

No license file was found in either imported repository snapshot. Treat this as study/reference material unless licensing is clarified.

## Why It Fits

- It is local-first.
- It uses a small embedding model and small local generation model.
- It teaches RAG as a pipeline, not a black box.
- It exposes the implementation details that matter for product work: chunking, embeddings, retrieval ranking, prompt construction, and grounding.
- It is small enough to refactor into a real package.

## Important Caveat

The tutorial is not yet a product.

It includes setup/download helpers and sample-document assumptions. For this repo's default offline path, model weights and sample data must already be staged locally. Runtime downloads should be treated as setup-only, not part of the product feature.

## Productization Path

### Stage 1: Preserve The Tutorial

Keep the imported tutorial as reference material. Do not edit upstream files directly unless intentionally creating a patched local fork.

Use:

- `README.md`
- `CHEATSHEET.md`
- `NOTES.md`
- `external-curriculum/rag-tutorial-source/python_tutorial.py`
- `external-curriculum/rag-tutorial-source/rag_tutorial_local_cur.ipynb`

### Stage 2: Extract The Pipeline

Create local product code outside `external-curriculum/`:

```text
src/retrieval/
  document_loader.py
  chunker.py
  embedder.py
  index.py
  retriever.py
  prompt_builder.py
  answerer.py
```

The first implementation can be simple:

- local JSON fixtures instead of PDFs
- sentence or field-aware chunking
- NumPy cosine similarity before vector databases
- deterministic fake embedder for tests
- local embedding model only for integration runs

### Stage 3: Replace Tutorial Domain Data

Replace the sample world-history document with report-item metadata fixtures:

```json
{
  "id": "item-001",
  "title": "Temperature Sweep Result",
  "type": "plot",
  "tags": ["thermal", "validation"],
  "section_hint": "Thermal Analysis",
  "summary": "Peak temperature comparison across simulated operating points."
}
```

The retrieval task becomes:

- find related report items
- group items into likely sections
- retrieve examples for section naming and ordering
- provide context for Template AST proposal

### Stage 4: Add Product Constraints

The tutorial can answer natural-language questions. The product feature should instead produce or support a structured object.

Target output:

- valid `Template AST`
- item ids only from selected inputs
- allowed section/layout values only
- no generated scientific claims
- validation before persistence

### Stage 5: Add Evaluation

Evaluate retrieval before evaluating generation.

Minimum evals:

- expected top-k report items for a query
- expected section grouping
- invalid item-id rejection
- empty-query behavior
- duplicate item behavior
- latency over fixture corpus

Metrics:

- recall@k
- precision@k
- mean reciprocal rank
- schema pass rate
- fallback rate
- human edit distance for generated template structure

### Stage 6: Package As A Product Feature

Move from notebook to service/module:

- explicit config
- local model path
- no runtime downloads
- hash checks for model artifacts
- structured logs
- test fixtures
- deterministic fallback
- feature flag

## How To Use It In The Study Guide

Use this tutorial during Phase 2 of `OFFLINE_STUDY_GUIDE.md`.

The tutorial's role is to make RAG concrete. The repo's role is to turn that concrete tutorial into a maintainable offline product feature.

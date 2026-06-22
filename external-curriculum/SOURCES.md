# External Curriculum Sources

This directory contains curated slices of public study repositories. It is not a full mirror of the upstream repositories.

For each source, the import intentionally strips translations, generated quiz apps, most media assets, cloud-only setup, Azure-specific labs, GitHub Models samples, OpenAI API samples, and unrelated lessons.

| Local directory | Upstream | Commit | License file |
| --- | --- | --- | --- |
| `production-rag` | `https://github.com/jamwithai/production-agentic-rag-course` | `424a0eb99edf841994f2a9a053912b489d2a94ff` | `production-rag/LICENSE` |
| `rag-tutorial` | `https://github.com/viseshrp/rag-tutorial` | `313427d1d56b2d7fb80b9ed2d6fb588814869931` | not found |
| `rag-tutorial-source` | `https://github.com/ismichel/rag_tutorial` | `ae908ee8a61dc1723f5386538bf2a1266c4cf0df` | not found |
| `ai-engineering-from-scratch` | `https://github.com/rohitg00/ai-engineering-from-scratch` | `574a5d6d10e31f3c2756a711af63a64981edf72a` | `ai-engineering-from-scratch/LICENSE` |
| `mcp-for-beginners` | `https://github.com/microsoft/mcp-for-beginners` | `af5f9c7439af3472534f50232c8f7dfdb61af122` | `mcp-for-beginners/LICENSE` |
| `generative-ai-for-beginners` | `https://github.com/microsoft/generative-ai-for-beginners` | `61a1240c5de4109ceac54142934411365c67c759` | `generative-ai-for-beginners/LICENSE` |
| `ml-for-beginners` | `https://github.com/microsoft/ML-For-Beginners` | `24028ae995117b45fabb883cf42114e721ed65b5` | `ml-for-beginners/LICENSE` |
| `ai-for-beginners` | `https://github.com/microsoft/AI-For-Beginners` | `fa78bc6fb0b30eea0678c27a54b915b79ad16fe8` | `ai-for-beginners/LICENSE` |
| `data-science-for-beginners` | `https://github.com/microsoft/Data-Science-For-Beginners` | `0d9af55c68ecc002f711944083751d4facb39843` | `data-science-for-beginners/LICENSE` |

## Offline Import Policy

- Do not add full upstream repositories here.
- Do not add provider-specific samples unless they are explicitly marked as excluded or rewritten for local execution.
- Keep source licenses with imported material.
- Prefer small, auditable lesson slices over broad mirrors.
- Any future refresh should update this file with the new commit SHA and a summary of changed folders.

## Fully Excluded Sources

`microsoft/ai-agents-for-beginners` was inspected but not retained in the offline curriculum. After removing provider-specific samples and platform-oriented files, too little portable material remained to justify importing the source. Agent concepts are covered through the local guide, the retained GenAI agents overview, MCP material, and selected `ai-engineering-from-scratch` phases.

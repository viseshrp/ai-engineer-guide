#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

forbidden='azure|foundry|github models|azure openai|openai api|api key|microsoft learn|cognitive services|power platform|power bi'
rag_forbidden='arxiv|jina|api key'

echo "Checking curated curriculum for provider-coupled content..."
if rg -n -i "$forbidden" external-curriculum docs OFFLINE_STUDY_GUIDE.md README.md AGENTS.md \
  --glob '!external-curriculum/SOURCES.md' \
  --glob '!scripts/check_offline_curriculum.sh'; then
  echo "Provider-coupled content found. Remove it from the default offline path or add a documented exception." >&2
  exit 1
fi

echo "Checking production RAG import for hosted embedding or public-ingestion remnants..."
if rg -n -i "$rag_forbidden" external-curriculum/production-rag; then
  echo "Production RAG import still contains hosted embedding or public-ingestion remnants." >&2
  exit 1
fi

echo "Checking that translations and nested git repos were not imported..."
if find external-curriculum \( -name .git -o -name translations -o -name translated_images \) -print | grep .; then
  echo "Unwanted upstream bulk content found." >&2
  exit 1
fi

echo "Offline curriculum checks passed."

# Study Resource Selection

This document evaluates candidate study resources against this repo's goal: become an applied AI engineer who can design, ship, evaluate, and operate AI-powered product features across domains.

The short-term product context is local-first, on-prem, and offline-friendly AI for scientific reporting software. That makes RAG, retrieval, structured outputs, local inference, evaluation, deterministic guardrails, and production integration more valuable than broad ML theory alone.

## Selection Criteria

Prioritize resources that help build production AI product features:

- Retrieval, search, RAG, embeddings, chunking, and evaluation
- Structured outputs, constrained generation, validation, and deterministic fallback
- Local/offline inference and model packaging
- Tool use, MCP, agent protocols, and product integration
- Security, privacy, observability, and deployment constraints
- Portfolio-grade projects that can become design docs, demos, and interview evidence

Deprioritize resources that are mainly:

- Generic beginner theory without product implementation
- Cloud-only API walkthroughs
- Vendor service tutorials that do not transfer cleanly
- Large curricula that delay useful applied work for months

## Recommended Order

### 1. `jamwithai/production-agentic-rag-course`

Verdict: **Use as the main short-term project spine, with offline substitutions.**

Why it fits:

- Strong match for production RAG and retrieval systems.
- Builds a concrete system with FastAPI, PostgreSQL, OpenSearch, Airflow, Docker, local LLMs, streaming, and tests.
- Starts with keyword search and hybrid retrieval instead of treating vector search as magic.
- Close to the type of AI feature that can be adapted to an existing product.

Use:

- Week 1 infrastructure foundation
- Week 3 BM25/OpenSearch search
- Week 4 chunking and hybrid retrieval
- Week 5 local LLM RAG pipeline
- Any testing, evaluation, or API design material

Adapt:

- Replace external embeddings with a local model where possible.
- Treat arXiv ingestion as a learning scaffold, then replace it with product metadata/report-item fixtures.
- Keep OpenSearch/FastAPI patterns only if they fit the host product architecture.

Flags:

- Uses external data and services in places, including arXiv APIs and Jina AI embeddings.
- Blog/Substack links are part of the learning path, but the repo itself appears to contain real code and MIT-licensed project material.
- Not purely air-gapped as written. Good architecture practice, but must be adapted for offline product constraints.

### 2. `rohitg00/ai-engineering-from-scratch`

Verdict: **Use as the long-term reference spine, not as a linear 320-hour course.**

Why it fits:

- Broad AI engineering map from math and ML foundations through transformers, LLM engineering, MCP, agents, and production.
- Strong "build it, then use the framework" philosophy.
- Good for filling gaps when a production feature exposes weak foundations.

Use selectively:

- NLP, information retrieval, embeddings, chunking, structured outputs, and LLM evaluation
- Transformers and LLM engineering when model behavior needs deeper understanding
- Tools, protocols, MCP, agent engineering, and production phases

Avoid:

- Completing all 503 lessons before building product features.
- Deep vision/audio/RL sections unless a future product use case needs them.

Flags:

- Promotional tone around the creator's related projects and website.
- Free and MIT-licensed, but very broad. The main risk is scope creep, not monetization.

### 3. `microsoft/mcp-for-beginners`

Verdict: **Use for protocol/tool integration after the first RAG foundations are underway.**

Why it fits:

- MCP is directly relevant to product-integrated AI features that need controlled access to tools, data, and services.
- Includes security, client-server concepts, multiple languages, server/client examples, and production-oriented modules.
- Useful for thinking about clean boundaries between the model layer and deterministic product capabilities.

Use:

- MCP fundamentals
- Python or TypeScript server/client examples
- Security module
- Database-backed or service-backed MCP examples

Adapt:

- Prefer local stdio or internal HTTP transport patterns for offline/on-prem deployments.
- Use the protocol concepts even if the first product feature does not expose MCP externally.

Flags:

- Microsoft-authored and includes Microsoft Foundry/Azure-oriented material.
- Some later modules are cloud/platform-specific; skip or translate those into local/internal deployment patterns.

### 4. `microsoft/generative-ai-for-beginners`

Verdict: **Use selected lessons as a practical GenAI primer; do not follow the cloud API path blindly.**

Why it fits:

- Covers core GenAI application topics: model selection, responsible AI, prompting, text generation, chat, embeddings/search, function calling, UX, and app integration.
- Good fast ramp for a full-stack engineer entering GenAI app development.

Use:

- Introduction to LLMs
- Model selection
- Responsible AI
- Prompting fundamentals and advanced prompts
- Text generation and chat application patterns
- Embeddings/search
- Function calling and structured interaction patterns

Adapt:

- Replace Azure OpenAI/OpenAI examples with local model runtimes when working on offline product features.
- Use the concepts, not the exact provider setup, as the durable learning.

Flags:

- Explicitly supports Azure OpenAI, GitHub Models, and OpenAI API.
- Vendor-led and cloud/API-oriented; useful, but not aligned with air-gapped constraints as written.
- Includes Microsoft startup/Azure/community links, so expect some product funneling.

### 5. `microsoft/ai-agents-for-beginners`

Verdict: **Use conceptually; be cautious with the code path.**

Why it fits:

- Covers agent use cases, tool use, agentic RAG, trustworthy agents, planning, multi-agent systems, production, protocols, context engineering, memory, browser use, and security.
- Useful for understanding where agent patterns are appropriate and where bounded workflows are better.

Use:

- Tool use
- Agentic design patterns
- Agentic RAG
- Trustworthy agents
- Agents in production
- Agentic protocols
- Context engineering
- Memory and security lessons

Avoid:

- Making the first feature an open-ended agent.
- Treating multi-agent systems as required architecture.

Flags:

- Code examples use Microsoft Agent Framework and Azure AI Foundry Agent Service.
- Azure account is required for the provided service path.
- Strong vendor/platform orientation. Use the concepts and translate to local/internal architecture.

### 6. `microsoft/ML-For-Beginners`

Verdict: **Optional foundation refresh, not a primary path.**

Why it fits:

- Good classic ML grounding with scikit-learn, evaluation, regression, classification, clustering, NLP basics, time series, and reinforcement learning.
- Helpful if model evaluation, feature engineering, or classic ML tradeoffs feel rusty.

Use selectively:

- Model evaluation and metrics
- Feature engineering
- Classification and clustering basics
- NLP basics if needed
- Responsible/fairness material

Skip for now:

- Most projects unless a specific gap appears.
- Reinforcement learning and time series unless needed for a product feature.

Flags:

- Microsoft-authored and links to Microsoft Learn/community resources.
- Mostly open educational content; not obviously freemium.
- Less directly useful for GenAI product shipping than the RAG/MCP/GenAI resources.

### 7. `microsoft/AI-For-Beginners`

Verdict: **Low priority. Use only for targeted conceptual gaps.**

Why it fits:

- Covers broad AI concepts, neural networks, computer vision, NLP, and deep learning.
- Useful if you need a slower conceptual pass through AI fundamentals.

Use selectively:

- Neural network basics
- Intro NLP/deep learning concepts
- Responsible AI or high-level AI survey material

Skip for now:

- Full 12-week curriculum.
- Computer vision/deep learning breadth unless a future product demands it.

Flags:

- Microsoft-authored and links to Azure AI Foundry/community material.
- More academic/beginner-oriented than your immediate applied AI engineering goal.

### 8. `microsoft/Data-Science-For-Beginners`

Verdict: **Lowest priority for this goal.**

Why it fits:

- Useful for data literacy, data preparation, visualization, ethics, and basic lifecycle thinking.

Use only if needed:

- Data preparation and visualization refresh
- Data science lifecycle overview
- Ethics basics

Skip:

- Full course.
- Anything that delays RAG, retrieval, structured outputs, local inference, and production integration.

Flags:

- Microsoft-authored and links to Microsoft Learn/community resources.
- Mostly open educational content; not a major sales pitch.
- Better for aspiring data scientists than applied AI product engineers.

## Practical Learning Path

1. Build the first production-RAG spine from `jamwithai/production-agentic-rag-course`, adapting every external dependency to local/offline equivalents.
2. Use `microsoft/generative-ai-for-beginners` for the missing GenAI application basics.
3. Use `microsoft/mcp-for-beginners` once tool boundaries and product integration become concrete.
4. Use selected `microsoft/ai-agents-for-beginners` lessons to understand agent patterns, but keep the first implementation bounded and auditable.
5. Use `rohitg00/ai-engineering-from-scratch` as the long-term map and gap-filler, especially for embeddings, retrieval, transformers, structured output, evaluation, MCP, agents, and production.
6. Pull from `ML-For-Beginners`, `AI-For-Beginners`, and `Data-Science-For-Beginners` only when a specific foundational gap blocks progress.

## Final Pick

For the next phase of this repo, use these as active resources:

- `jamwithai/production-agentic-rag-course`
- `microsoft/generative-ai-for-beginners`
- `microsoft/mcp-for-beginners`
- Selected lessons from `microsoft/ai-agents-for-beginners`
- Selected phases from `rohitg00/ai-engineering-from-scratch`

Keep these as reference-only:

- `microsoft/ML-For-Beginners`
- `microsoft/AI-For-Beginners`
- `microsoft/Data-Science-For-Beginners`

## Clone And Prune Plan

These repositories are generally self-contained enough to clone locally and keep only the useful curriculum. The main pruning rule is:

- Keep English curriculum, concepts, diagrams, local examples, tests, and portable architecture notes.
- Strip translations, generated quiz apps, cloud-service setup, Azure-specific notebooks, GitHub Models examples, OpenAI API examples, low-code/vendor demos, and unrelated media-heavy assets.
- When a lesson is valuable but the sample code is provider-specific, keep the lesson README and replace the code with a local/offline implementation later.

### `jamwithai/production-agentic-rag-course`

Clone value: **High. Keep code, but adapt external dependencies.**

Keep:

- `README.md`
- `.env.example`
- `pyproject.toml`, `uv.lock`, `Makefile`, `Dockerfile`, `compose.yml`
- `src/`
- `tests/`
- `notebooks/week1`, `notebooks/week3`, `notebooks/week4`, `notebooks/week5`
- `airflow/` only if orchestration becomes relevant
- `static/week*_*.png` diagrams if useful

Strip or replace:

- arXiv ingestion as the permanent domain source
- Jina embeddings client; replace with local embeddings
- Telegram bot integration unless needed
- Langfuse/MinIO/ClickHouse monitoring stack until observability work is explicit
- Any hosted/external API dependency

Reasoning:

The repo is compact and code-heavy. It is the best practical project spine, but it is not air-gapped as written.

### `rohitg00/ai-engineering-from-scratch`

Clone value: **High as a selective reference. Do not keep everything.**

Keep:

- `README.md`
- `ROADMAP.md`
- `glossary/`
- Selected folders from:
  - `phases/05-nlp-foundations-to-advanced`
  - `phases/07-transformers-deep-dive`
  - `phases/08-generative-ai`
  - `phases/11-llm-engineering`
  - `phases/13-tools-and-protocols`
  - `phases/14-agent-engineering`
  - `phases/17-infrastructure-and-production`
  - `phases/18-ethics-safety-alignment`
  - `phases/19-capstone-projects`
- `projects/` only if a project maps to this repo's roadmap

Strip:

- `site/`, `web/`, `.claude/`, promotional/support files, broad assets
- Most of math, vision, audio, RL, multimodal, autonomous systems, and swarm material until needed
- Generated outputs that are not directly useful

Reasoning:

The content is broad and mostly local/reference friendly. The risk is scope creep, not Azure lock-in.

### `microsoft/mcp-for-beginners`

Clone value: **Medium-high. Keep protocol fundamentals; strip Microsoft platform labs.**

Keep:

- `00-Introduction`
- `01-CoreConcepts`
- `02-Security`
- `03-GettingStarted/01-first-server`
- `03-GettingStarted/02-client`
- `03-GettingStarted/03-llm-client` only as a concept reference
- `03-GettingStarted/05-stdio-server`
- `03-GettingStarted/06-http-streaming`
- `03-GettingStarted/08-testing`
- `03-GettingStarted/10-advanced`
- `04-PracticalImplementation`
- `05-AdvancedTopics/mcp-contextengineering`
- `05-AdvancedTopics/mcp-integration`
- `05-AdvancedTopics/mcp-protocol-features`
- `05-AdvancedTopics/mcp-routing`
- `05-AdvancedTopics/mcp-security`
- `05-AdvancedTopics/mcp-transport`
- `08-BestPractices`
- `09-CaseStudy/docs-mcp`
- `11-MCPServerHandsOnLabs/01-Architecture` through `11-MCPServerHandsOnLabs/08-Testing`

Strip:

- `translations/`, `translated_images/`
- Azure AI Toolkit / AI Foundry content
- Entra-specific security content unless enterprise auth becomes relevant
- OAuth demos until a product feature requires auth delegation
- realtime web search examples
- deployment labs that assume cloud services

Reasoning:

MCP is highly relevant, but the repo mixes portable protocol material with Microsoft platform integrations.

### `microsoft/generative-ai-for-beginners`

Clone value: **Medium. Keep curriculum READMEs; strip most provider code.**

Keep:

- `00-course-setup/02-setup-local.md`
- `00-course-setup/03-providers.md` only as provider comparison context
- `01-introduction-to-genai`
- `02-exploring-and-comparing-different-llms`
- `03-using-generative-ai-responsibly`
- `04-prompt-engineering-fundamentals/README.md`
- `05-advanced-prompts/README.md`
- `06-text-generation-apps/README.md`
- `07-building-chat-applications/README.md`
- `08-building-search-applications/README.md`
- `11-integrating-with-function-calling/README.md`
- `12-designing-ux-for-ai-applications`
- `13-securing-ai-applications`
- `14-the-generative-ai-application-lifecycle`
- `15-rag-and-vector-databases`
- `16-open-source-models`
- `17-ai-agents` as concept-only
- `19-slm`
- Selected `shared/python` utilities only if they are provider-neutral

Strip:

- `translations/`, `translated_images/`, `presentations/`
- `00-course-setup/01-setup-cloud.md`
- all `aoai-*` Azure OpenAI files
- all `githubmodels-*` files
- all `oai-*` OpenAI API files unless used only as pseudocode
- `09-building-image-applications`
- `10-building-low-code-ai-applications`
- `18-fine-tuning` for now
- `20-mistral` and `21-meta` if they require GitHub Models or hosted provider flows

Reasoning:

The concepts are useful, but most runnable samples are cloud/API-first. Treat this as reading material to be reimplemented locally.

### `microsoft/ai-agents-for-beginners`

Clone value: **Medium-low for code, medium for concepts.**

Keep:

- `01-intro-to-ai-agents/README.md`
- `02-explore-agentic-frameworks/README.md`
- `03-agentic-design-patterns/README.md`
- `04-tool-use/README.md`
- `05-agentic-rag/README.md`
- `06-building-trustworthy-agents/README.md`
- `07-planning-design/README.md`
- `09-metacognition/README.md`
- `10-ai-agents-production/README.md`
- `11-agentic-protocols/README.md`
- `11-agentic-protocols/code_samples/mcp-agents`
- `12-context-engineering/README.md`
- `12-context-engineering/code_samples/vacation_agent_scratchpad.md`
- `13-agent-memory/README.md`
- `18-securing-ai-agents/README.md`

Strip:

- `translations/`, `translated_images/`
- `00-course-setup/AzureSearch.*`
- `02-explore-agentic-frameworks/azure-ai-foundry-agent-creation.md`
- most `code_samples/*agent-framework*`
- `14-microsoft-agent-framework`
- Azure AI Foundry examples
- GitHub Models examples
- Semantic Kernel samples unless explicitly comparing frameworks
- browser-use demos unless a future local browser-control feature matters

Reasoning:

The curriculum can teach agent vocabulary and design tradeoffs, but the code path is heavily Microsoft/Azure/GitHub Models oriented. For this repo, keep the conceptual lessons and rebuild small local examples from scratch.

### `microsoft/ML-For-Beginners`

Clone value: **Low-medium. Keep as a foundation reference only.**

Keep:

- `1-Introduction/3-fairness`
- `1-Introduction/4-techniques-of-ML`
- `2-Regression`
- `4-Classification`
- `5-Clustering`
- `6-NLP`
- `9-Real-World/2-Debugging-ML-Models`
- selected `data/` needed by kept lessons

Strip:

- `translations/`, `translated_images/`
- `quiz-app/`, `pdf/`, `sketchnotes/`
- R and Julia solutions unless specifically wanted
- `7-TimeSeries`
- `8-Reinforcement`
- most generated solution artifacts

Reasoning:

Mostly local/classic ML material, not Azure-heavy. Useful only when a specific foundation gap appears.

### `microsoft/AI-For-Beginners`

Clone value: **Low-medium. Keep NLP/transformer foundation only if needed.**

Keep:

- `lessons/3-NeuralNetworks/03-Perceptron`
- `lessons/3-NeuralNetworks/05-Frameworks/IntroPyTorch.ipynb`
- `lessons/5-NLP/13-TextRep`
- `lessons/5-NLP/14-Embeddings`
- `lessons/5-NLP/18-Transformers`
- `lessons/5-NLP/20-LangModels`
- `lessons/7-Ethics`

Strip:

- `translations/`, `translated_images/`
- `etc/quiz-app`, `etc/quiz-src`, generated PDFs
- most computer vision lessons
- symbolic AI, genetic algorithms, RL, and extra multimodal lessons for now
- TensorFlow duplicate notebooks if using PyTorch

Reasoning:

This is more academic/beginner than the current goal. It is local enough, but not central.

### `microsoft/Data-Science-For-Beginners`

Clone value: **Low. Keep only a tiny data-prep/statistics subset.**

Keep:

- `1-Introduction/02-ethics`
- `1-Introduction/04-stats-and-probability`
- `2-Working-With-Data/05-relational-databases`
- `2-Working-With-Data/07-python`
- `2-Working-With-Data/08-data-preparation`
- `4-Data-Science-Lifecycle/14-Introduction`
- `4-Data-Science-Lifecycle/15-analyzing`
- selected `data/` files required by those lessons

Strip:

- `translations/`, `translated_images/`
- `quiz-app/`, `sketchnotes/`, most `images/`
- `3-Data-Visualization` unless needed
- all `5-Data-Science-In-Cloud`, especially Azure and low-code lessons
- `6-Data-Science-In-Wild` unless wanted as light reading
- R-specific material

Reasoning:

Mostly useful for data literacy. It is not a primary AI-engineering resource.

## Repository Import Recommendation

Do not vendor all eight full repositories into this repo. They contain tens of thousands of files, mainly due to translations, images, notebooks, and generated quiz apps.

If material is copied locally, create a `resources/` or `external-curriculum/` directory and import only curated folders. Keep a small `SOURCE.md` beside each imported resource with:

- original repository URL
- commit SHA
- license
- folders kept
- folders intentionally stripped
- any local/offline substitutions made

Best first import:

1. Curated `jamwithai/production-agentic-rag-course`
2. Selected `microsoft/mcp-for-beginners` protocol lessons
3. Selected `microsoft/generative-ai-for-beginners` README-only lessons
4. Selected `rohitg00/ai-engineering-from-scratch` phase folders

## Implemented Offline Import

The actual imported curriculum is stricter than the initial ranking above.

After local inspection and pruning, the repo keeps:

- `production-rag` as architecture/reference material only, with public-ingestion and hosted-embedding remnants removed.
- `mcp-for-beginners` protocol and local transport material.
- `generative-ai-for-beginners` only where the retained material stays provider-neutral.
- `ai-engineering-from-scratch` selected phases for NLP, GenAI, LLM engineering, tools/protocols, agents, production, safety, and capstones.
- Narrow reference slices from `ML-For-Beginners`, `AI-For-Beginners`, and `Data-Science-For-Beginners`.

The repo does **not** retain `microsoft/ai-agents-for-beginners` in `external-curriculum/`. Once provider-specific and platform-oriented material was removed, too little portable content remained. Agent concepts are covered through the offline guide, retained GenAI overview material, MCP lessons, and selected `ai-engineering-from-scratch` phases.

The default path is [OFFLINE_STUDY_GUIDE.md](./OFFLINE_STUDY_GUIDE.md), not the upstream course order.

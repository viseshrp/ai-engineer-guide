# Offline Security And Privacy

## Hard Rules

- No outbound network calls from the feature.
- No hosted model APIs.
- No runtime model downloads.
- No telemetry to external services.
- No unscoped file access from model tools.
- No secrets in prompts.
- No private source code in prompts unless explicitly required and approved.

## Model Artifact Rules

- Model files must be installed locally.
- Model paths must be configured explicitly.
- Model artifacts should be hash-verified before use.
- Model versions must be recorded in evaluation reports.
- Model licenses must allow the intended use and redistribution model.

## Tool Rules

- Tools expose narrow product capabilities, not arbitrary filesystem or shell access.
- Tools return structured data.
- Tool inputs are schema-validated.
- Tool outputs are sanitized before being passed back to a model.
- Tool calls are logged locally.

## Data Rules

- Use the minimum metadata needed for the task.
- Avoid including raw report contents unless required.
- Redact sensitive fields from evaluation fixtures.
- Keep test fixtures synthetic or scrubbed.

## Review Checklist

- Can the feature run with the network disabled?
- Can the feature run with no external service credentials configured?
- Are model files local and pinned?
- Does invalid model output fail closed?
- Are all persisted objects created through deterministic validation?
- Can a user tell when AI proposed a structure?
- Is there a deterministic fallback?

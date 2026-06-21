# Curriculum Maintenance

## Current State

The repo contains a curated offline curriculum in `external-curriculum/`.

The imported source clones were reduced from roughly 9 GB of upstream material to about 116 MB of local content by removing:

- translations
- generated quiz apps
- nested git metadata
- broad media assets
- cloud-service setup
- provider-specific runnable samples
- hosted-model API examples
- unrelated beginner-course sections

## Update Process

1. Clone or refresh upstream repositories outside this repo.
2. Copy only the folders listed in `STUDY_RESOURCES.md`.
3. Strip provider-coupled files.
4. Update `external-curriculum/SOURCES.md` with commit SHAs.
5. Run:

```bash
scripts/check_offline_curriculum.sh
```

6. Update `OFFLINE_STUDY_GUIDE.md` only if the default offline path changes.

## Default Rule

The default curriculum must remain runnable and understandable without network access. External links in upstream source material are acceptable only as historical citations, not as required steps.

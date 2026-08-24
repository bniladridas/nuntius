# Changelog

## [1.0.1](https://github.com/palmshed/nuntius/compare/nuntius-rb/v1.0.0...nuntius-rb/v1.0.1) (2026-08-24)
### Documentation

* update install instructions for stable 1.0.0 release ([d0ce00f](https://github.com/palmshed/nuntius/commit/d0ce00f9c09325c4ad073b8e15b3ef7e7b5592d1))

## Changelog

<br>

All notable changes are tracked here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) · Versioning: [SemVer](https://semver.org/spec/v2.0.0.html)

<br>

## [1.0.0]

<br>

### Changed

- Canonical Gemini model configuration: `config/models.yaml` is the single source of truth (default `gemini-3.7-flash`, fallback `gemini-3.6-flash`, stable baseline `gemini-3.5-flash`); Ruby and Python consumers load it at runtime, env overrides unchanged
- Pro family (`gemini-pro-latest`, `gemini-3-pro-preview`, `gemini-3.1-pro-preview`, `gemini-2.5-pro`) retired from active choices: requires billing, Free-Tier quota is 0; deprecated aliases warn and fall back to `:flash`; `pro_2_0` kept as legacy alias
- Client default model changed from `:pro` to `:flash`; image-to-text uses Flash; unknown symbols fall back to Flash

<br>

### Added

- Fallback model wiring: `complex_model` in the Python review app (`NUNTIUS_GEMINI_FALLBACK_MODEL` override)
- Test coverage: moderation unit tests, CLI integration tests, SimpleCov reporting via `COVERAGE=true` (HTML + lcov)

<br>

### Fixed

- Dependency ownership: `pyproject.toml` is canonical for Python (`api/requirements.txt` and `nuntius/requirements.lock` generated); gemspec declares runtime deps correctly (`dotenv`, `base64` moved to runtime so installed gems work)

<br>

### Removed

- Legacy Workflow Mode archived to `archive/workflow/` (Webhook Mode is current); `nuntius/manual.js` kept active for `analysis.yml`
- Dead macOS helper code `lib/mac/` and its test

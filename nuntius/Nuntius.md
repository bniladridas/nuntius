# Nuntius

<br>

Nuntius reviews pull requests with Gemini and posts review comments. It can also apply changes when authoring is enabled.

<br>

# Setup

<br>

Use the hosted GitHub App at https://github.com/apps/nuntius-review, or create your own GitHub App from GitHub settings. The app needs repository permissions for contents read, issues read/write, and pull requests read/write. For webhook mode, subscribe it to pull request, issue comment, and pull request review comment events. Generate a private key and install the app on the repositories Nuntius should review.

<br>

Set these secrets where Nuntius runs: `GEMINI_API_KEY`, `NUNTIUS_CLIENT_ID`, `NUNTIUS_APP_ID`, `NUNTIUS_PRIVATE_KEY`, and `WEBHOOK_SECRET`. `NUNTIUS_CLIENT_ID` is used by GitHub Actions token creation. `NUNTIUS_APP_ID` is still used by webhook mode. `NUNTIUS_GEMINI_API_KEY` can be set when Nuntius should use a different Gemini key from the rest of the project.

<br>

# Webhook Mode

<br>

Webhook mode is the default path for new installs. One hosted deployment receives GitHub App webhooks and can review every repository where the app is installed. Put the secrets in the hosting platform, such as Vercel. If you self-host outside Vercel, run the Flask app behind a WSGI server such as Gunicorn.

<br>

Nuntius treats GitHub installation tokens as opaque strings. GitHub may return longer `ghs_` tokens, and Nuntius does not depend on token shape or length.

<br>

# Workflow Mode (Archived)

<br>

Workflow Mode is archived. Files were moved to `archive/workflow/` on 2026-08-23. New installs should use Webhook Mode above. Existing installs that still use the workflow can copy from the archive at their own risk.

<br>

Archived files: `archive/workflow/nuntius.yml` (workflow), `archive/workflow/setup-nuntius` (installer), and `archive/workflow/suggestions.js` (Node helper). `nuntius/manual.js` remains active for `analysis.yml`.

<br>

Historical setup (for reference only, not current):

<br>

```bash
curl -fsSL https://raw.githubusercontent.com/palmshed/nuntius/main/archive/workflow/setup-nuntius | bash
```

<br>

The archived workflow required `GEMINI_API_KEY`, `NUNTIUS_CLIENT_ID`, and `NUNTIUS_PRIVATE_KEY`, and ran on pull request open or update.

<br>

# Commands

<br>

Comment `/analyze` on a pull request to run a fresh review. Comment `/apply` to apply suggestions when `enable_authoring: true` is set and the app has write access. Comment `/merge`, `/squash`, or `/rebase` to merge when the app has the needed permission.

<br>

For a manual run, use:

<br>

```bash
python nuntius/nuntius.py --repo owner/repo --pr 123
```

<br>

# Authoring

<br>

Authoring lets Nuntius commit changes to pull request branches or open improvement pull requests. Enable it in `nuntius/config.yaml` with `enable_authoring: true`, then set `auto_commit_suggestions`, `create_improvement_prs`, and `improvement_branch_pattern` as needed. The GitHub App or token must have write access.

<br>

# Retrieval Context

<br>

Retrieval context is optional and off by default. When enabled, Nuntius can fetch a small amount of package, security, GitHub, or docs context before review.

<br>

```yaml
enable_rag: true
rag_sources: [pypi, npm, rubygems, security, github, docs]
```

<br>

Optional source keys include `NEWS_API_KEY`, `OPENWEATHER_API_KEY`, `YOUTUBE_API_KEY`, `SNYK_API_KEY`, `KAGGLE_API_KEY`, `SONARCLOUD_TOKEN`, `CONFLUENCE_URL`, and `CONFLUENCE_API_KEY`.

<br>

# Configuration

<br>

Use `nuntius/config.yaml` for review focus, temperature, token limits, authoring settings, and the default Gemini model. The default model is `gemini-3.7-flash` (fallback `gemini-3.6-flash` via `complex_model`). Override with `NUNTIUS_GEMINI_MODEL` (and `NUNTIUS_GEMINI_FALLBACK_MODEL`). Only the Flash family is Free-Tier verified: `gemini-3.5-flash-lite`/`3.1-flash-lite` for lightweight workloads, and `3.5-flash`/`3-flash-preview` if needed. Pro is retired until billing is enabled.

<br>

# Troubleshooting

<br>

For archived Workflow Mode (see `archive/workflow/`), check the GitHub Actions run, repository secrets, and pull request permissions. For Webhook Mode, check the Vercel project logs under Functions, GitHub webhook delivery status, environment variables, app installation, webhook URL, and webhook secret.

<br>

Common failures are invalid Gemini keys, Gemini quota or rate limits, webhook signature mismatches, and missing GitHub App permissions. Quota cooldown is controlled by `NUNTIUS_QUOTA_COOLDOWN_SECONDS`; the default is `1800`.

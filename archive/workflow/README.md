# Workflow Mode (Archived)

Workflow Mode is archived as of 2026-08-23. Files were moved from
`.github/workflows/nuntius.yml`, `bin/setup-nuntius`, and
`nuntius/suggestions.js` to this directory.

New installs should use Webhook Mode (`api/webhook.py`, `vercel.json`).
Existing installs that still use the workflow can copy from the archive
at their own risk. The archived workflow required `GEMINI_API_KEY`,
`NUNTIUS_CLIENT_ID`, and `NUNTIUS_PRIVATE_KEY`, and ran on pull request
open or update.

`nuntius/manual.js` is kept active because `.github/workflows/analysis.yml`
still executes `node nuntius/manual.js`. It can be retired separately
along with that workflow.

To restore, copy the workflow back to `.github/workflows/` and the
helpers to their original locations, or run the archived installer:

```bash
curl -fsSL https://raw.githubusercontent.com/palmshed/nuntius/main/archive/workflow/setup-nuntius | bash
```

Salure Preprocessors

## BrynQ PR Checks

This repo runs the standard BrynQ customer PR checks (24 rules — file hygiene, Dockerfile, uv lock, interface structure, banned imports).

**Rules:** see [`brynq-ai-toolkit/pr-review/customer/RULES.md`](https://github.com/BrynQ/brynq-ai-toolkit/blob/main/pr-review/customer/RULES.md)

### Enable the pre-push hook (one-time, ~10 seconds)

```bash
bash scripts/install-hooks.sh
```

This clones `brynq-ai-toolkit` to `~/.brynq-ai-toolkit` (if not already there) and configures git to run checks before every push. Re-run anytime to pull the latest rules.

### What runs automatically (no setup needed)

- **GitHub Action** `Customer PR Checks` runs on every PR. Required for merge once branch protection is enabled.

### Optional: local AI reviewer

If you use Claude Code:
```bash
ln -sf ~/.brynq-ai-toolkit/pr-review/customer/skill ~/.claude/skills/pr-review-customer
```
Then run `/pr-review-customer` inside this repo for an AI-assisted review (SDK usage, error handling, pandas idioms, hardcoded config, etc.).

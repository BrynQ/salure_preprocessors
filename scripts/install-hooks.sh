#!/usr/bin/env bash
# One-time setup for BrynQ customer interface PR checks.
#
# What this does:
#   1. Clones (or updates) brynq-ai-toolkit at $HOME/.brynq-ai-toolkit
#   2. Configures git to use .githooks/ as the hooks directory in THIS repo
#
# Re-running is safe. Pulls latest toolkit each time.

set -euo pipefail

TOOLKIT_DIR="${BRYNQ_AI_TOOLKIT:-$HOME/.brynq-ai-toolkit}"

echo "── BrynQ pre-push hook install ──"
echo "  toolkit: $TOOLKIT_DIR"

if [ -d "$TOOLKIT_DIR/.git" ]; then
    echo "  updating toolkit..."
    git -C "$TOOLKIT_DIR" fetch --quiet origin main
    git -C "$TOOLKIT_DIR" reset --hard --quiet origin/main
else
    echo "  cloning toolkit..."
    rm -rf "$TOOLKIT_DIR"
    git clone --depth 1 https://github.com/BrynQ/brynq-ai-toolkit "$TOOLKIT_DIR" --quiet
fi

if [ ! -d ".githooks" ]; then
    echo "  ⚠ .githooks/ not found in this repo — pull latest from origin first" >&2
    exit 1
fi

# Make hook executable
if [ -f ".githooks/pre-push" ]; then
    chmod +x .githooks/pre-push
fi

# Configure git
git config core.hooksPath .githooks

echo ""
echo "✅ Done. Pre-push hook active for this repo."
echo "   Toolkit will auto-update on next 'install-hooks.sh' run."
echo ""
echo "   Test by running:  bash .githooks/pre-push"

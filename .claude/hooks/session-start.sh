#!/bin/bash
# Install REA (rea-agents) and connect it to Claude Code in cloud sessions.
set -euo pipefail
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0

# Pinned so a new npm release is never run automatically; bump deliberately.
REA_VERSION="6.1.0"
npx -y "rea-agents@${REA_VERSION}" setup --client claude_code --yes --format json > /dev/null

# Claude Code reads skills from ~/.claude/skills, not ~/.agents/skills.
mkdir -p "$HOME/.claude/skills"
ln -sfn "$HOME/.agents/skills/reverse-engineer-anything" "$HOME/.claude/skills/reverse-engineer-anything"

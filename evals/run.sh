#!/bin/bash
# Runs each scenario in evals/prompts.txt (format: id|prompt) in a fresh headless
# Claude Code session with this skill installed, writing replies to evals/out/<id>.md.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
WS="$(mktemp -d)"
mkdir -p "$WS/.claude/skills" "$REPO/evals/out"
ln -s "$REPO" "$WS/.claude/skills/rental-car-coverage"
cd "$WS"
while IFS='|' read -r id prompt; do
  # stdin must be closed, or claude reads the rest of prompts.txt as part of the prompt
  claude -p "$prompt" --allowedTools "Skill Read Glob Grep WebSearch WebFetch" \
    < /dev/null > "$REPO/evals/out/$id.md" 2>&1 &
done < "$REPO/evals/prompts.txt"
wait
echo "Replies written to $REPO/evals/out/"

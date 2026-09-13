#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <path_to_project>"
  exit 1
fi

TARGET_PROJECT="$1"

if [ ! -d "$TARGET_PROJECT" ]; then
  mkdir -p "$TARGET_PROJECT"
fi

TARGET_PROJECT="$(cd "$TARGET_PROJECT" && pwd)"
echo "Configuring project at: $TARGET_PROJECT"

# 1. Setup .agents/skills symlink
mkdir -p "$TARGET_PROJECT/.agents"
SKILLS_DEST="$TARGET_PROJECT/.agents/skills"
rm -rf "$SKILLS_DEST"
ln -s "$ROOT_DIR/skills" "$SKILLS_DEST"
echo "  [LINKED] .agents/skills -> $ROOT_DIR/skills"

# 2. Setup AGENTS.md if missing
if [ ! -f "$TARGET_PROJECT/AGENTS.md" ]; then
  cp "$ROOT_DIR/agents/general.md" "$TARGET_PROJECT/AGENTS.md"
  echo "  [CREATED] AGENTS.md (from agents/general.md)"
else
  echo "  [EXISTS]  AGENTS.md already present (skipped)"
fi

# 3. Setup CLAUDE.md symlink if missing (points to AGENTS.md)
if [ ! -e "$TARGET_PROJECT/CLAUDE.md" ]; then
  (cd "$TARGET_PROJECT" && ln -s "AGENTS.md" "CLAUDE.md")
  echo "  [LINKED]  CLAUDE.md -> AGENTS.md"
fi

echo ""
echo "Setup complete! Ready for Gemini, Claude, and Codex."

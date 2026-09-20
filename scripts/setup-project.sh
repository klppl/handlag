#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

USE_AGENTSEED=false
TARGET_PROJECT=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --agentseed|--seed)
      USE_AGENTSEED=true
      shift
      ;;
    *)
      if [ -z "$TARGET_PROJECT" ]; then
        TARGET_PROJECT="$1"
      fi
      shift
      ;;
  esac
done

if [ -z "$TARGET_PROJECT" ]; then
  echo "Usage: $0 <path_to_project> [--agentseed]"
  exit 1
fi

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

# 2. Setup AGENTS.md
if [ "$USE_AGENTSEED" = true ]; then
  echo "  [AGENTSEED] Analyzing codebase and generating AGENTS.md..."
  (cd "$TARGET_PROJECT" && npx --yes agentseed init)

  # Harmonize with handlag operational baseline if not already present
  if ! grep -q "Scandinavian minimalist" "$TARGET_PROJECT/AGENTS.md" 2>/dev/null; then
    cat <<EOF >> "$TARGET_PROJECT/AGENTS.md"

---

## Operational & Behavioral Baseline (handlag)

$(cat "$ROOT_DIR/agents/general.md")
EOF
    echo "  [MERGED]  Appended handlag operational rules into AGENTS.md"
  fi
elif [ ! -f "$TARGET_PROJECT/AGENTS.md" ]; then
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

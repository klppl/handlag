#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

ERRORS=0
WARNINGS=0

echo "Auditing handlag skill repository..."

if [ -f "$SCRIPT_DIR/update-prompts-index.sh" ]; then
  "$SCRIPT_DIR/update-prompts-index.sh"
fi

if [ ! -f sources.json ]; then
  echo "❌ ERROR: sources.json missing."
  exit 1
fi

if ! jq empty sources.json 2>/dev/null; then
  echo "❌ ERROR: sources.json is invalid JSON."
  exit 1
fi

TRACKED_SKILLS=$(jq -r '.[].name' sources.json)

# Check tracked skills exist in filesystem
for NAME in $TRACKED_SKILLS; do
  if [ -z "$NAME" ]; then
    continue
  fi
  if [ ! -d "skills/$NAME" ]; then
    echo "❌ ERROR: Tracked skill '$NAME' missing in skills/$NAME"
    ERRORS=$((ERRORS + 1))
  else
    if [ ! -f "skills/$NAME/SOURCE.md" ]; then
      echo "❌ ERROR: Skill '$NAME' missing SOURCE.md"
      ERRORS=$((ERRORS + 1))
    fi
    if [ ! -f "skills/$NAME/SKILL.md" ]; then
      echo "⚠️  WARNING: Skill '$NAME' missing SKILL.md"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi
done

# Check filesystem skills exist in sources.json
if [ -d skills ]; then
  for DIR in skills/*; do
    if [ -d "$DIR" ]; then
      NAME=$(basename "$DIR")
      MATCH=$(jq -r --arg name "$NAME" '.[] | select(.name == $name) | .name' sources.json)
      if [ -z "$MATCH" ]; then
        echo "❌ ERROR: Directory 'skills/$NAME' is not registered in sources.json"
        ERRORS=$((ERRORS + 1))
      fi
    fi
  done
fi

echo "----------------------------------------"
if [ "$ERRORS" -gt 0 ]; then
  echo "Audit failed with $ERRORS error(s) and $WARNINGS warning(s)."
  exit 1
else
  echo "Audit passed cleanly ($WARNINGS warning(s))."
  exit 0
fi

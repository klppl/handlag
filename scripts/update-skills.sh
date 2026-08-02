#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

if [ ! -f sources.json ]; then
  echo "Error: sources.json not found." >&2
  exit 1
fi

echo "Updating all vendored skills from sources.json..."

jq -c '.[]' sources.json | while read -r ITEM; do
  REPO=$(echo "$ITEM" | jq -r '.repo')
  SUBPATH=$(echo "$ITEM" | jq -r '.subpath // ""')
  NAME=$(echo "$ITEM" | jq -r '.name')

  if [ -n "$REPO" ] && [ -n "$NAME" ]; then
    if [ -n "$SUBPATH" ]; then
      FULL_TARGET="$REPO/$SUBPATH"
    else
      FULL_TARGET="$REPO"
    fi
    echo "----------------------------------------"
    echo "Updating skill '$NAME' ($FULL_TARGET)..."
    ./scripts/add-skill.sh "$FULL_TARGET" "$NAME"
  fi
done

echo "----------------------------------------"
echo "All skills updated successfully."

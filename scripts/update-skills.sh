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

jq -r '.[] | "\(.repo) \(.name)"' sources.json | while read -r REPO NAME; do
  if [ -n "$REPO" ] && [ -n "$NAME" ]; then
    echo "----------------------------------------"
    echo "Updating skill '$NAME' ($REPO)..."
    ./scripts/add-skill.sh "$REPO" "$NAME"
  fi
done

echo "----------------------------------------"
echo "All skills updated successfully."

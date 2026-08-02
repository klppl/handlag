#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <name>"
  exit 1
fi

NAME="$1"
TARGET_DIR="skills/$NAME"

FOUND=false

if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
  echo "Removed directory $TARGET_DIR."
  FOUND=true
fi

if [ -f sources.json ]; then
  TMP_JSON=$(mktemp)
  jq --arg name "$NAME" 'map(select(.name != $name))' sources.json > "$TMP_JSON" && mv "$TMP_JSON" sources.json
  echo "Updated sources.json (removed '$NAME')."
  FOUND=true
fi

if [ "$FOUND" = false ]; then
  echo "Skill '$NAME' was not found in skills/ or sources.json."
else
  echo "Successfully removed skill '$NAME'."
fi

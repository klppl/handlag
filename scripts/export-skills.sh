#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

TARGET="${ANTIGRAVITY_SKILLS_DIR:-"$HOME/.gemini/antigravity/skills"}"
MODE="copy"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --symlink)
      MODE="symlink"
      shift
      ;;
    *)
      TARGET="$1"
      shift
      ;;
  esac
done

if [ ! -d skills ]; then
  echo "Error: skills/ directory not found." >&2
  exit 1
fi

mkdir -p "$TARGET"
echo "Exporting skills to $TARGET (mode: $MODE)..."

for DIR in skills/*; do
  if [ -d "$DIR" ]; then
    NAME=$(basename "$DIR")
    ABS_SRC="$(cd "$DIR" && pwd)"
    DEST="$TARGET/$NAME"

    if [ "$MODE" = "symlink" ]; then
      rm -rf "$DEST"
      ln -s "$ABS_SRC" "$DEST"
      echo "  [SYMLINK] $NAME -> $DEST"
    else
      rm -rf "$DEST"
      cp -R "$ABS_SRC" "$DEST"
      echo "  [COPIED]  $NAME -> $DEST"
    fi
  fi
done

echo "Export completed successfully."

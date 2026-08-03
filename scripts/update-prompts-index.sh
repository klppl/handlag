#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

if [ ! -d prompts ]; then
  exit 0
fi

INDEX_FILE="prompts/README.md"
TMP_FILE=$(mktemp)

cat <<EOF > "$TMP_FILE"
# AI Prompts Collection

Ready-to-use, battle-tested AI prompts for code analysis, security auditing, refactoring, and development workflows.

## 📚 Prompt Index

| Prompt | Description |
| :--- | :--- |
EOF

for FILE in prompts/*.md; do
  [ -e "$FILE" ] || continue
  BASENAME=$(basename "$FILE")
  [ "$BASENAME" = "README.md" ] && continue

  TITLE=$(grep -E '^# ' "$FILE" | head -n 1 | sed 's/^# //' || echo "$BASENAME")
  DESC=$(grep -v '^#' "$FILE" | grep -v '^---' | grep -v '^[[:space:]]*$' | head -n 1 || echo "")

  echo "| [$TITLE]($BASENAME) | $DESC |" >> "$TMP_FILE"
done

cat <<EOF >> "$TMP_FILE"

## 🛠 How to Use

1. Click any prompt above.
2. Copy the text inside the **Copy-Paste Prompt** block.
3. Paste directly into your AI coding assistant (Antigravity, Cursor, Claude, ChatGPT, etc.).
EOF

mv "$TMP_FILE" "$INDEX_FILE"
echo "Updated $INDEX_FILE successfully."

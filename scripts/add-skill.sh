#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <owner/repo[/subpath]> [name]"
  exit 1
fi

INPUT_PATH="$1"
# Extract owner/repo (first 2 parts)
REPO_BASE=$(echo "$INPUT_PATH" | cut -d'/' -f1,2)

# Extract subpath if exists (everything after owner/repo/)
if [[ "$INPUT_PATH" =~ ^[^/]+/[^/]+/(.+)$ ]]; then
  SUBPATH="${BASH_REMATCH[1]}"
else
  SUBPATH=""
fi

NAME="${2:-$(basename "$INPUT_PATH")}"
TARGET_DIR="skills/$NAME"

mkdir -p skills

echo "Fetching commit SHA for $REPO_BASE..."
COMMIT=$(git ls-remote "https://github.com/$REPO_BASE" HEAD | awk '{print $1}')

if [ -z "$COMMIT" ]; then
  echo "Error: Could not retrieve commit SHA for https://github.com/$REPO_BASE" >&2
  exit 1
fi

echo "Vendoring $INPUT_PATH into $TARGET_DIR..."
npx degit "$INPUT_PATH" "$TARGET_DIR" --force

NOW=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

# Check if skill already exists in sources.json to preserve original 'added' date
EXISTING_ADDED=""
if [ -f sources.json ]; then
  EXISTING_ADDED=$(jq -r --arg name "$NAME" '.[] | select(.name == $name) | .added // empty' sources.json || true)
fi

ADDED="${EXISTING_ADDED:-$NOW}"
UPDATED="$NOW"

# Extract description from SKILL.md if present
DESCRIPTION=""
if [ -f "$TARGET_DIR/SKILL.md" ]; then
  DESCRIPTION=$(sed -n '/^---/,/^---/p' "$TARGET_DIR/SKILL.md" | grep -i '^description:' | head -n 1 | sed -E 's/^description:[[:space:]]*['\''"]?([^'\''"]+)['\''"]?/\1/' | tr -d '\r' || true)
  if [[ "$DESCRIPTION" == "|" ]] || [[ "$DESCRIPTION" == ">" ]] || [ -z "$DESCRIPTION" ]; then
    DESCRIPTION=$(sed -n '/^---/,/^---/p' "$TARGET_DIR/SKILL.md" | awk '/^description:/{flag=1; next} /^  /{if(flag){print; exit}} /^[^ ]/{flag=0}' | sed -E 's/^[[:space:]]+//' | tr -d '\r' || true)
  fi
fi

cat <<EOF > "$TARGET_DIR/SOURCE.md"
# Source

- **Repo:** https://github.com/$REPO_BASE
EOF

if [ -n "$SUBPATH" ]; then
  echo "- **Subpath:** $SUBPATH" >> "$TARGET_DIR/SOURCE.md"
fi

cat <<EOF >> "$TARGET_DIR/SOURCE.md"
- **Commit:** $COMMIT
- **Added:** $ADDED
- **Updated:** $UPDATED
EOF

TMP_JSON=$(mktemp)
if [ ! -f sources.json ]; then
  echo "[]" > sources.json
fi

jq --arg name "$NAME" \
   --arg repo "$REPO_BASE" \
   --arg subpath "$SUBPATH" \
   --arg commit "$COMMIT" \
   --arg added "$ADDED" \
   --arg updated "$UPDATED" \
   --arg description "$DESCRIPTION" \
   'if any(.[]; .name == $name) then
      map(if .name == $name then
        .repo = $repo |
        .subpath = (if $subpath != "" then $subpath else null end) |
        .commit = $commit |
        .added = (if .added then .added else $added end) |
        .updated = $updated |
        .description = (if $description != "" then $description else .description end)
      else . end)
    else
      . + [{
        "name": $name,
        "repo": $repo,
        "subpath": (if $subpath != "" then $subpath else null end),
        "commit": $commit,
        "added": $added,
        "updated": $updated,
        "description": (if $description != "" then $description else null end)
      }]
    end' \
   sources.json > "$TMP_JSON" && mv "$TMP_JSON" sources.json

echo "Successfully added/updated skill '$NAME' from $INPUT_PATH ($COMMIT)."

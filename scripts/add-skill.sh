#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <owner/repo> [name]"
  exit 1
fi

REPO="$1"
NAME="${2:-$(basename "$REPO")}"
TARGET_DIR="skills/$NAME"

mkdir -p skills

echo "Fetching commit SHA for $REPO..."
COMMIT=$(git ls-remote "https://github.com/$REPO" HEAD | awk '{print $1}')

if [ -z "$COMMIT" ]; then
  echo "Error: Could not retrieve commit SHA for $REPO" >&2
  exit 1
fi

echo "Vendoring $REPO into $TARGET_DIR..."
npx degit "$REPO" "$TARGET_DIR" --force

ADDED=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

cat <<EOF > "$TARGET_DIR/SOURCE.md"
# Source

- **Repo:** https://github.com/$REPO
- **Commit:** $COMMIT
- **Added:** $ADDED
EOF

TMP_JSON=$(mktemp)
if [ ! -f sources.json ]; then
  echo "[]" > sources.json
fi

jq --arg name "$NAME" \
   --arg repo "$REPO" \
   --arg commit "$COMMIT" \
   --arg added "$ADDED" \
   '. += [{"name": $name, "repo": $repo, "commit": $commit, "added": $added}]' \
   sources.json > "$TMP_JSON" && mv "$TMP_JSON" sources.json

echo "Successfully added skill '$NAME' from $REPO ($COMMIT)."

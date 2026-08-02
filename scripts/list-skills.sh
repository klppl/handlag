#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

if [ ! -f sources.json ] || [ "$(jq 'length' sources.json 2>/dev/null || echo 0)" -eq 0 ]; then
  echo "No skills registered in sources.json."
  exit 0
fi

echo "================================================================================"
printf "%-15s %-32s %-10s %-20s\n" "NAME" "SOURCE REPO" "COMMIT" "ADDED/UPDATED"
echo "================================================================================"

jq -r '.[] | "\(.name)\t\(.repo)\(if .subpath then "/" + .subpath else "" end)\t\(.commit[0:7])\t\(.added // .updated // "")\t\(.description // "")"' sources.json | while IFS=$'\t' read -r NAME REPO COMMIT ADDED DESC; do
  printf "%-15s %-32s %-10s %-20s\n" "$NAME" "$REPO" "$COMMIT" "$ADDED"
  if [ -n "$DESC" ]; then
    printf "  └─ Description: %s\n" "$DESC"
  fi
done
echo "================================================================================"

#!/usr/bin/env bash
# Rebuild english-coach.skill from skills/english-coach/.
# Run this after editing SKILL.md or anything under references/,
# then re-install the .skill so the saved skill matches the repo.
set -euo pipefail

cd "$(dirname "$0")"

SRC="skills/english-coach"
OUT="english-coach.skill"

[ -f "$SRC/SKILL.md" ] || { echo "error: $SRC/SKILL.md not found" >&2; exit 1; }

rm -f "$OUT"
( cd skills && zip -q -r -D -X "../$OUT" english-coach -x '*.DS_Store' )

echo "Rebuilt $OUT from $SRC/"
unzip -l "$OUT"

#!/usr/bin/env bash
# Rebuild english-coach.skill from .claude/skills/english-coach/.
#
# A GitHub Action runs this on every push that touches the skill source, so you
# normally don't need to. Run it locally when you want the package immediately.
# The zip is deterministic (fixed timestamps, sorted entries): identical content
# produces identical bytes, so it never shows up as a spurious diff.
set -euo pipefail

cd "$(dirname "$0")"

SRC=".claude/skills/english-coach"
OUT="english-coach.skill"

[ -f "$SRC/SKILL.md" ] || { echo "error: $SRC/SKILL.md not found" >&2; exit 1; }

python3 - "$SRC" "$OUT" <<'PY'
import os, sys, zipfile

src, out = sys.argv[1], sys.argv[2]
root = os.path.basename(src)

entries = []
for dirpath, dirnames, filenames in os.walk(src):
    dirnames.sort()
    for name in sorted(filenames):
        if name == ".DS_Store" or name.startswith("._"):
            continue
        full = os.path.join(dirpath, name)
        arc = os.path.join(root, os.path.relpath(full, src))
        entries.append((arc, full))
entries.sort()

if not entries:
    sys.exit("error: no files found under %s" % src)

with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED, compresslevel=6) as z:
    for arc, full in entries:
        info = zipfile.ZipInfo(arc, date_time=(2026, 1, 1, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = 0o644 << 16
        with open(full, "rb") as fh:
            z.writestr(info, fh.read())

print("Rebuilt %s from %s/ (%d files)" % (out, src, len(entries)))
for arc, _ in entries:
    print("  " + arc)
PY

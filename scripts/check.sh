#!/usr/bin/env bash
# Usage: scripts/check.sh [novel-dir ...]        lint skills + each novel's map
#        scripts/check.sh --frontier <novel-dir>  list open, unclaimed, unblocked tickets
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"

if [ "${1:-}" = "--frontier" ]; then
  tdir="${2:?usage: check.sh --frontier <novel-dir>}/map/tickets"
  for t in "$tdir"/*.md; do
    grep -q '^Status: open$' "$t" || continue
    ok=1
    for id in $(sed -n 's/^Blocked by: *//p' "$t" | tr ',' ' '); do
      grep -q '^Status: resolved$' "$tdir/$id"-*.md 2>/dev/null || ok=0
    done
    [ "$ok" = 1 ] && echo "$(basename "$t" .md) ($(sed -n 's/^Type: //p' "$t"))"
  done
  exit 0
fi
fail=0
err() { echo "FAIL $*"; fail=1; }

for skill in "$root"/.agents/skills/*/SKILL.md; do
  dir="$(dirname "$skill")"; name="$(basename "$dir")"
  [ "$(head -1 "$skill")" = "---" ] || err "$skill: no frontmatter"
  grep -q "^name: $name$" "$skill" || err "$skill: name is not '$name'"
  grep -q "^description: ." "$skill" || err "$skill: missing description"
done

# Relative markdown links in skills must resolve.
for f in "$root"/.agents/skills/*/*.md; do
  grep -o '](\.\{0,2\}/\?[^)#:]*\.md)' "$f" | sed 's/^](//; s/)$//' | while read -r link; do
    [ -e "$(dirname "$f")/$link" ] || echo "FAIL $f: broken link $link"
  done
done | grep . && fail=1

affects_item='^(ch[0-9]+|act (I|II|III|IV)|vol [0-9]+( act (I|II|III|IV)| ending)?)$'
for novel in "$@"; do
  tdir="$novel/map/tickets"
  [ -d "$tdir" ] || { err "$novel: no map/tickets"; continue; }
  for t in "$tdir"/*.md; do
    b="$(basename "$t")"
    [[ "$b" =~ ^[0-9]{2}-.+\.md$ ]] || err "$b: name is not NN-slug.md"
    grep -Eq '^Type: (grilling|research|sketch|task)$' "$t" || err "$b: bad or missing Type"
    grep -Eq '^Status: (open|claimed|resolved)$' "$t" || err "$b: bad or missing Status"
    grep -q '^## Question' "$t" || err "$b: missing ## Question"
    if grep -q '^Status: resolved' "$t"; then grep -q '^## Answer' "$t" || err "$b: resolved without ## Answer"; fi
    blocked="$(sed -n 's/^Blocked by: *//p' "$t")"
    for id in ${blocked//,/ }; do
      ls "$tdir/$id"-*.md >/dev/null 2>&1 || err "$b: Blocked by $id does not exist"
    done
    affects="$(sed -n 's/^Affects: *//p' "$t")"
    [ -n "$affects" ] || err "$b: missing Affects"
    IFS=',' read -ra items <<< "$affects"
    for item in "${items[@]}"; do
      item="$(echo "$item" | xargs)"
      [[ "$item" =~ $affects_item ]] || err "$b: bad Affects item '$item'"
    done
  done
  # Decisions so far is an index: one short clause per line (wikilinks excluded from the count).
  if [ -f "$novel/map/map.md" ]; then
    sed -n '/^## Decisions so far/,/^## /{/^- /p}' "$novel/map/map.md" | while read -r line; do
      words=$(echo "$line" | sed 's/\[\[[^]]*\]\]//g' | wc -w)
      [ "$words" -le 30 ] || echo "FAIL map.md: Decisions line has $words words (max 30): ${line:0:60}..."
    done | grep . && fail=1
  fi
done

[ "$fail" = 0 ] && echo "ok"
exit "$fail"

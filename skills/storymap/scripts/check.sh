#!/usr/bin/env bash
# Lives at skills/storymap/scripts/check.sh, so it travels with the storymap skill.
# Usage: check.sh [novel-dir ...]        lint stories + the skills tree
#        check.sh --frontier <novel-dir> list open, unclaimed, unblocked tickets
set -u
skills_dir="$(cd "$(dirname "$0")/../.." && pwd)"
fail=0
err() { echo "FAIL $*"; fail=1; }

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

# Skills: frontmatter must name the directory, and relative markdown links must resolve.
for skill in "$skills_dir"/*/SKILL.md; do
  [ -e "$skill" ] || continue
  dir="$(dirname "$skill")"; name="$(basename "$dir")"
  [ "$(head -1 "$skill")" = "---" ] || err "$skill: no frontmatter"
  grep -q "^name: $name$" "$skill" || err "$skill: name is not '$name'"
  grep -q "^description: ." "$skill" || err "$skill: missing description"
done

for f in "$skills_dir"/*/*.md; do
  grep -o '](\.\{0,2\}/\?[^)#:]*\.md)' "$f" | sed 's/^](//; s/)$//' | while read -r link; do
    [ -e "$(dirname "$f")/$link" ] || echo "FAIL $f: broken link $link"
  done
done | grep . && fail=1

affects_item='^(ch[0-9]+|act (I|II|III|IV)|vol [0-9]+( act (I|II|III|IV)| ending)?)$'
for novel in "$@"; do
  # Thread ledger: unique IDs, known kind and status, exactly one status line, a paid: line means status paid.
  th="$novel/codex/threads.md"
  if [ -f "$th" ]; then
    awk '
      function close_t() { if (id != "") {
          if (nstatus != 1) print "FAIL threads.md: " id " has " nstatus " status lines"
          if (paidline && status !~ /^paid \(ch[0-9]+\)$/) print "FAIL threads.md: " id " has a paid: line but status " status } }
      /^T[0-9]+ · / { close_t(); id = $1; nstatus = 0; paidline = 0; status = ""
          if (seen[id]++) print "FAIL threads.md: duplicate " id
          split($0, f, " · ")
          if (f[2] !~ /^(promise|callback|foreshadow|mystery|motif|red-herring)$/) print "FAIL threads.md: " id " bad kind " f[2]
          if (f[3] !~ /^[MICE]$/) print "FAIL threads.md: " id " bad MICE tag " f[3]
          next }
      id != "" && /^  status: / { nstatus++; status = substr($0, 11)
          if (status !~ /^(open|paid \(ch[0-9]+\)|dropped \(.+\))$/) print "FAIL threads.md: " id " bad status " status }
      id != "" && /^  paid: / { paidline = 1 }
      END { close_t() }' "$th" | grep . && fail=1
    ids=" $(grep -o '^T[0-9]*' "$th" | tr '\n' ' ') "
  fi

  # Summaries: every manuscript chapter has one, it cites only known Threads, and its title matches the outline line.
  ol="$novel/codex/outline.md"
  for m in "$novel"/manuscript/ch*.md; do
    [ -e "$m" ] || continue
    c="$(basename "$m" .md)"; s="$novel/summaries/$c.md"
    if [ ! -f "$s" ]; then [ -f "$novel/map/map.md" ] && err "$c: no summary"; continue; fi
    if [ -f "$th" ]; then
      for t in $(sed -n 's/^- Threads: *//p' "$s" | grep -o 'T[0-9]*'); do
        [[ "$ids" == *" $t "* ]] || err "summaries/$c.md: cites unknown $t"
      done
    fi
    if [ -f "$ol" ]; then
      line="$(grep -m1 "^- $c — " "$ol")"
      if [ -z "$line" ]; then err "outline.md: no line for $c"; else
        want="$(echo "${line#- $c — }" | sed 's/ · .*//; s/: .*//')"
        have="$(head -1 "$s" | sed "s/^# $c — //")"
        [ "$have" = "$want" ] || err "summaries/$c.md: title '$have' differs from outline '$want'"
      fi
    fi
  done

  tdir="$novel/map/tickets"
  if [ ! -d "$tdir" ]; then
    # Mid-Adopt (a queue, no map yet) has no tickets until Chart runs.
    [ -f "$novel/map/adopt-queue.md" ] && [ ! -f "$novel/map/map.md" ] || err "$novel: no map/tickets"
    continue
  fi
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

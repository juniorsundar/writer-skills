#!/usr/bin/env bash
# Stable, deliberately small voice measurements; requires Bash and gawk.
set -euo pipefail
selftest=0; outliers=0; table=0; baseline=(); files=()
if [[ ${1:-} == --selftest ]]; then selftest=1; shift
elif [[ ${1:-} == --table ]]; then table=1; shift; files=("$@")
elif [[ ${1:-} == --outliers ]]; then
  outliers=1; shift
  while (($#)) && [[ $1 != -- ]]; do baseline+=("$1"); shift; done
  [[ ${1:-} == -- ]] || { echo 'usage: voice-stats.sh --outliers baseline... -- chapter' >&2; exit 2; }; shift; files=("$@")
else files=("$@")
fi
if (( selftest )); then
  dir=$(mktemp -d); trap 'rm -rf "$dir"' EXIT
  # Frontmatter is stripped; the mid-text --- is a scene break, not frontmatter; narration is not "untagged dialogue".
  printf '%s\n' '---' 'title: Test' '---' 'One two.' 'Three four five!' '"Go now," she said.' '' '---' '' 'Six seven.' > "$dir/base.md"
  printf '%s\n' 'A b c d e.' 'Two words.' > "$dir/target.md"
  actual=$("$0" "$dir/base.md"); out=$("$0" --outliers "$dir/base.md" -- "$dir/target.md"); tab=$("$0" --table "$dir/base.md" "$dir/target.md")
  [[ $actual == *'Sentences: 4'* && $actual == *'mean 2.75 · median 2 · p5 2 · p95 3'* && $actual == *'Dialogue share: 0.25'* \
     && $actual == *'said 1 · other 0 · untagged 0'* && $actual == *'Narration length (words): median 2 · p5 2 · p95 2'* \
     && $out == *'bounds: 2–3 words'* && $out == *'5 words: A b c d e'* && $out != *'Two words'* \
     && $tab == *$'base.md\t4\t2\t3\t2\t0.25'* && $tab == *$'TOTAL\t6\t2\t4\t2\t0.17'* ]] \
    || { printf 'selftest failed:\n%s\n%s\n%s\n' "$actual" "$out" "$tab" >&2; exit 1; }
  echo 'selftest: ok'; exit 0
fi
((${#files[@]})) || { echo 'usage: voice-stats.sh [chapter.md ...] | --table chapter.md... | --outliers baseline.md... -- chapter.md' >&2; exit 2; }
for f in "${baseline[@]}" "${files[@]}"; do [[ -r $f ]] || { echo "cannot read: $f" >&2; exit 2; }; done
# shortcut: punctuation boundaries and whitespace words approximate sentences/words; upgrade when tokenization fidelity matters.
# shortcut: a sentence containing a double quote counts as dialogue; tags are a nearby speech verb, untagged = quoted with none; upgrade when reliable attribution matters.
# shortcut: fixed auxiliary/verb lists approximate tense and ignore context; upgrade when grammatical tense matters.
# shortcut: blank lines and scene-break rules (---, ***, ___) are paragraph boundaries; upgrade when source formatting varies.
gawk -v mode="$outliers" -v table="$table" -v nbase="${#baseline[@]}" '
BEGIN {if(mode && ARGC-1-nbase!=1){print "need baseline chapters and exactly one target" > "/dev/stderr"; exit 2}
 if(table) print "chapter\tsentences\tmedian\tp95\tnarration_median\tdialogue_share"}
function trim(s){sub(/^[[:space:]]+/,"",s); sub(/[[:space:]]+$/,"",s); return s}
function clean(s){
  if (FNR==1 && s ~ /^---[[:space:]]*$/) { front=1; return "" }
  if (front) { if (s ~ /^---[[:space:]]*$/) front=0; return "" }
  if (s ~ /^[[:space:]]*(---+|\*\*\*+|___+)[[:space:]]*$/) return ""
  gsub(/```[^`]*```/," ",s); gsub(/`[^`]*`/," ",s)
  gsub(/!\[[^]]*\]\([^)]*\)/," ",s); gsub(/\[[^]]*\]\([^)]*\)/," ",s)
  gsub(/[*_>#~]/," ",s); gsub(/^[[:space:]]*[-+]?[[:space:]]+/,"",s)
  return s
}
function words(s, t,n,a){t=trim(s); if(t=="")return 0; n=split(t,a,/[[:space:]]+/); return n}
function flushpara(){if(pcount){para[++pn]=pcount; pcount=0}}
function sentence(s, len, lower){s=trim(s); if(s=="")return; len=words(s); sent[++sn]=s; sl[sn]=len; pcount++
 lower=tolower(s)
 if(s !~ /"/) nl[++nn]=len
 if(s ~ /"/){qn++
   if(lower ~ /(^|[^[:alpha:]])said([^[:alpha:]]|$)/) said++
   else if(lower ~ /(^|[^[:alpha:]])(asked|replied|whispered|shouted|muttered|called|cried|answered|added|remarked|yelled)([^[:alpha:]]|$)/) other++
   else untag++}
 if(lower ~ /(^|[^[:alpha:]])(was|were|had|did|went|saw|said|felt|looked|walked|made|took)([^[:alpha:]]|$)/) past++
 if(lower ~ /(^|[^[:alpha:]])(is|are|am|has|have|does|do|goes|sees|says|feels|looks|walks|makes|takes)([^[:alpha:]]|$)/) present++
}
function addtext(s, n,a,i,x){s=clean(s); if(s==""){flushpara(); return}
 n=split(s,a,/[.!?]+["\047)]*[[:space:]]+/); for(i=1;i<=n;i++){x=a[i]; if(x ~ /[[:alnum:]]/) sentence(x)}
}
function quant(arr,n,p,  s){n=asort(arr,s); return s[int((n-1)*p)+1]}
function row(f,a,n,b,m,q){printf "%s\t%d\t%s\t%s\t%s\t%.2f\n",f,n,(n?quant(a,n,.5):"-"),(n?quant(a,n,.95):"-"),(m?quant(b,m,.5):"-"),(n?q/n:0)}
function report(c,f,  i,sum,ps){if(c>1)printf "\n"; printf "CHAPTER %s\n",f; printf "Sentences: %d\n",sn; if(!sn)return
 for(i=1;i<=sn;i++)sum+=sl[i]; for(i=1;i<=pn;i++)ps+=para[i]
 printf "Sentence length (words): mean %.2f · median %g · p5 %g · p95 %g\n",sum/sn,quant(sl,sn,.5),quant(sl,sn,.05),quant(sl,sn,.95)
 printf "Paragraph length (sentences): mean %.2f · median %g · p5 %g · p95 %g\n",ps/pn,quant(para,pn,.5),quant(para,pn,.05),quant(para,pn,.95)
 if(nn) printf "Narration length (words): median %g · p5 %g · p95 %g\n",quant(nl,nn,.5),quant(nl,nn,.05),quant(nl,nn,.95)
 printf "Dialogue share: %.2f\n",qn/sn
 printf "Dialogue tags: said %d · other %d · untagged %d\n",said,other,untag
 printf "Tense signal: past %d · present %d\n",past,present}
FNR==1 {front=0; pcount=0; curfile=FILENAME; chapter++}
{addtext($0)}
ENDFILE {flushpara()
 if(mode && chapter<=nbase){for(i=1;i<=sn;i++)base[++bn]=sl[i]}
 else if(mode){if(!bn){print "baseline has no sentences" > "/dev/stderr"; exit 2}
   lo=quant(base,bn,.05); hi=quant(base,bn,.95); printf "Baseline sentence-length bounds: %d–%d words\n",lo,hi
   for(i=1;i<=sn;i++) if(sl[i]<lo||sl[i]>hi) printf "%d words: %s\n",sl[i],sent[i]}
 else if(table){f=curfile; sub(/.*\//,"",f); row(f,sl,sn,nl,nn,qn)
   for(i=1;i<=sn;i++)alls[++as]=sl[i]; for(i=1;i<=nn;i++)alln[++an]=nl[i]; aq+=qn}
 else report(chapter,curfile)
 sn=0; pn=0; nn=0; qn=said=other=untag=past=present=0; delete sl; delete sent; delete para; delete nl}
END {if(table) row("TOTAL",alls,as,alln,an,aq)}
' "${baseline[@]}" "${files[@]}"

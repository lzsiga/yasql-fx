usage samples:

  YaSql=../yasql.in               ./test0004.sh
  YaSql=/usr/local/bin/yasql.orig ./test0004.sh

more complex sample:

  for i in ./test????.sh; do
      d=$(dirname "$i")
      c=$(basename "$i" .sh)
      YaSql=../yasql.in "$i" &>"$c".out.old
      YaSql=/usr/local/bin/yasql.orig "$i" &>"$c".out.new
      if cmp "$c".out.old "$c".out.new 2>/dev/null; then
          echo "$i gave the same results"
      else
          echo "$i gave different results"
      fi
  done

list of tests:

  test0001.sh - demonstrates a problem that has been solved in version 1.83-1
  test0002.sh - demonstrates utf8 compatibility
  test0003.sh - testing lexical parser: comments and literals
  test0004.sh - testing lexical parser: pl/sql blocks
  test0005.sh - testing lexical parser: create function/object
  test0006.sh - testing lexical parser: misplaced slash-terminator
  test0007.sh - demonstrates iso-8859-1 compatibility
  test0008.sh - demonstrates iso-8859-2 compatibility
  test0009.sh - demonstrates special ending sequences

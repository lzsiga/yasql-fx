usage samples:

  YaSql=../yasql.in               ./test0004.sh
  YaSql=/usr/local/bin/yasql.orig ./test0004.sh

using script compareOldnew.sh:

    $ Old=/usr/local/bin/yasql.orig New=../yasql.in ./compareOldnew.sh test0015.sh

    running './test0015.sh' with Old='/usr/local/bin/yasql.orig'
    running './test0015.sh' with New='../yasql.in'
    log-files 'test0015.old.log' and 'test0015.new.log' differ

    $ diff -u 'test0015.old.log' 'test0015.new.log'

note:

  yasql-fx (the new version) doesn't use charsets from environment variables
  NLS_LANG and NLS_NCHAR, it goes with AL32UTF8

list of tests:

  test0001.sh - demonstrates a problem that has been solved in version 1.83-1
  test0002.sh - demonstrates utf8 compatibility
  test0003.sh - testing lexical parser: comments and literals
  test0004.sh - testing lexical parser: pl/sql blocks (cf test0004.txt)
  test0005.sh - testing lexical parser: create function/object
  test0006.sh - testing lexical parser: misplaced slash-terminator
  test0007.sh - demonstrates iso-8859-1 compatibility
  test0008.sh - demonstrates iso-8859-2 compatibility
  test0009.sh - demonstrates special ending sequences
  test0010.sh - testing 'describe table' (cf test0010.txt)
  test0011.sh - testing '\i' terminator (uses table 'emp')
  test0012.sh - testing different column-types
  test0013.sh - testing describe with synonyms
  test0014.sh - testing describe over database link
  test0015.sh - testing 'prompt' (write literal to stdout)
  test0016.sh - handing standalone comment (single or multiline)
  test0017.sh - testing multiline fields
  test0018.sh - error-indicator-placement
  test0019.sh - demonstrates that 'begin' in the statement doesn't always means pl/sql

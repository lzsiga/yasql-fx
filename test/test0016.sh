#!/bin/sh

# Testing standalone comment

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/gyartas_test.dbuid) <<DONE

prompt singleline comment, followed by select
-- This should be ignored
SELECT * FROM dual;

prompt singleline comment, followed by describe
-- This should be ignored
describe dual

prompt multiline comment, followed by select
  /* This should be ignored
   */
SELECT * FROM dual;

prompt multiline comment, followed by describe
  /* This should be ignored
   */
describe dual

prompt more comments, followed by select
  -- ignore this
  /* This should be ignored
   */
  -- of no importance
SELECT * FROM dual;

prompt more comment, followed by describe
  -- ignore this
  /* This should be ignored
   */
  -- of no importance
describe dual

exit
DONE

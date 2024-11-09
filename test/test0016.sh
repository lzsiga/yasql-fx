#!/bin/sh

# Testing standalone comments (not inside a SQL-statement)
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE

prompt
prompt ===
prompt singleline comment, followed by select
-- This should be ignored
SELECT * FROM dual;

prompt
prompt ===
prompt singleline comment, followed by describe
-- This should be ignored
describe dual

prompt
prompt ===
prompt multiline comment, followed by select
  /* This should be ignored
   */
SELECT * FROM dual;

prompt
prompt ===
prompt multiline comment, followed by describe
  /* This should be ignored
   */
describe dual

prompt
prompt ===
prompt more comments
  -- ignore this
  /* This should be ignored
   */
  -- of no importance
SELECT * FROM dual;

prompt
prompt ===
prompt more comment, followed by describe
  -- ignore this
  /* This should be ignored
   */
  -- of no importance
describe dual

prompt
prompt ===
prompt comment in the same line, followed by select
/* select */ select * from dual;

prompt
prompt ===
prompt comment in the same line, followed by describe
/* describe */ describe dual

exit
DONE

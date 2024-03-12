#!/bin/sh

# This script was originally meant to demonstrate a simple problem:
# semicolon(;) in comment causes error message.
# Eventually, I had to refactor the lexical parser

# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

set -u

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE
-- Nothing special,
-- just testing semicolon in comment
-- "quotes and "apostles should be ignored as well
-- there's no nested comments comments either /*
/* multiline comments 'should' work too
   "comment' -- "body'
*/
SELECT 'Done -- Bye' FROM dual;
SELECT /* nested
comment
here */ * FROM -- singleline comment here
dual;
DONE

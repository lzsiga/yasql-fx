#!/bin/sh

# This script calls pl/sql blocks

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
-- testing declare
declare
begin
   /* comment inside */
   dbms_output.put_line('It was not long'); -- singleline comment
   /* multi
      line
      comment */
   dbms_output.put_line('Multiline
   literal'); -- singleline comment
end;
/
/* now we start with 'begin' */
begin
   /* comment inside */
   dbms_output.put_line('It was not long'); -- singleline comment
   /* multi
      line
      comment */
   dbms_output.put_line('Multiline
   literal'); -- singleline comment
end;
/
DONE

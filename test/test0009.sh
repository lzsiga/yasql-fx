#!/bin/sh

# This script demonstrates special ending sequences
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8
printf '\nThis test should work on utf8-compatible terminal\n\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
SELECT deptno,dname FROM dept ORDER BY deptno;
\g
\S
DONE

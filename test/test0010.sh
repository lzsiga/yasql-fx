#!/bin/sh

# Testing 'describe'

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8
#printf '\nThis test should work on utf8-compatible terminal\n\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
@ttab0001.sql
DESCRIBE yasql_ttab_0001
DONE

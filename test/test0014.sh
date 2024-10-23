#!/bin/sh

# Testing describe over database link
# this requires a database link called 'my_dblink'
# and tables on the remote site called 'remtable' and 'remuser.remtable'

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/gyartas_test.dbuid) <<DONE
describe dual@my_dblink
describe remtable@my_dblink
describe remuser.remtable@my_dblink
DONE

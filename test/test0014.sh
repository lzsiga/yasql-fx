#!/bin/sh

# Testing describe over database link
# this requires a database link called 'my_dblink'
# and tables on the remote site called 'remtable' and 'remuser.remtable'
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
describe dual@my_dblink
describe remtable@my_dblink
describe remuser.remtable@my_dblink
DONE

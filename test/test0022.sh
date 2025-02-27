#!/bin/sh

# Defining and calling a stored procedure
# using character set UTF-8

# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=hu_HU.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
-- explicitely defined characterset
@UTF-8:test0022.sql

SELECT yasql_tfun_0022(1) FROM dual;
SELECT yasql_tfun_0022(2) FROM dual;
SELECT yasql_tfun_0022(3) FROM dual;
SELECT yasql_tfun_0022(4) FROM dual;

exit
DONE

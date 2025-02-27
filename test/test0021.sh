#!/bin/sh

# Defining and calling a stored procedure
# using character set ISO-8859-2

# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=hu_HU.ISO-8859-2
export NLS_LANG=american_america.EE8ISO8859P2
export NLS_NCHAR=EE8ISO8859P2
printf '\nThis test should work on 8-bit terminal (ISO-8859-2)\n\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
-- explicitely defined characterset
@iso-8859-2:test0021.sql

SELECT yasql_tfun_0021 FROM dual;

exit
DONE

#!/bin/sh

# This script demonstrates 8-bit-compatibility (ISO-8859-1)
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.ISO-8859-1
export NLS_LANG=american_america.WE8ISO8859P1
export NLS_NCHAR=WE8ISO8859P1
printf '\nThis test should work on 8-bit terminal (ISO-8859-1)\n\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
-- the result of this depends on NLS_CHARACTERSET (server-side) and NLS_LANG (client-side)
SELECT 'áéíóú äëîöü' X FROM dual;

-- this test uses NCHAR
-- the result depends on both NLS_CHARACTERSET and NLS_NCHAR_CHARACTERSET (server-side)
SELECT N'áéíóú äëîöü' X FROM dual;

-- this uses NCHAR too, also unistr with unicodes
-- (this does not depend on NLS_CHARACTERSET)
SELECT unistr('\00e1\00e9\00ed\00f3\00fa\0020\00e4\00eb\00ee\00f6\00fc') X FROM dual;

-- nchar and unistr
select nchr(201)||nchr(219) NC,unistr('\00c9')||unistr('\00db') US from dual;
DONE

#!/bin/sh

# This script demonstrates 8-bit-compatibility (ISO-8859-2)
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
-- the result of this depends on NLS_CHARACTERSET (server-side) and NLS_LANG (client-side)
SELECT 'árvíztûrõ tükörfúrógép' X FROM dual;

-- this test uses NCHAR
-- the result depends on both NLS_CHARACTERSET and NLS_NCHAR_CHARACTERSET (server-side)
-- and NLS_NCHAR (client-side)
SELECT N'árvíztûrõ tükörfúrógép' X FROM dual;

-- this uses NCHAR with unistr with unicodes
-- (this does not depend on NLS_CHARACTERSET)
SELECT unistr('\00e1rv\00edzt\0171r\0151') X FROM dual;

SELECT unistr('\00e1rv\00edzt\0171r\0151') X FROM dual; >tmp.latin2
! cat tmp.latin2

-- nchar and unistr
select nchr(201)||nchr(368) NC,unistr('\00c9')||unistr('\0170') US from dual;
DONE

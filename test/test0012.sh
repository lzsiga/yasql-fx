#!/bin/sh

# Testing different column types

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
@ttab0001.sql

SELECT c12c,  c12b,  nc12,  vc12c, vc12b FROM yasql_ttab_0001;
SELECT nvc12, raw12, int1,  int2,  int3  FROM yasql_ttab_0001;
SELECT num12, num20, num84, num93        FROM yasql_ttab_0001;
SELECT f1,    f2,    f3                  FROM yasql_ttab_0001;
SELECT dt     FROM yasql_ttab_0001;
SELECT ts     FROM yasql_ttab_0001;
SELECT ts_tz  FROM yasql_ttab_0001;
SELECT ts_ltz FROM yasql_ttab_0001;

SELECT c12c,  c12b,  nc12,  vc12c, vc12b FROM yasql_ttab_0001 \i
SELECT nvc12, raw12, int1,  int2,  int3  FROM yasql_ttab_0001 \i
SELECT num12, num20, num84, num93        FROM yasql_ttab_0001 \i
SELECT f1,    f2,    f3                  FROM yasql_ttab_0001 \i
SELECT dt     FROM yasql_ttab_0001 \i
SELECT ts     FROM yasql_ttab_0001 \i
SELECT ts_tz  FROM yasql_ttab_0001 \i
SELECT ts_ltz FROM yasql_ttab_0001 \i
DONE

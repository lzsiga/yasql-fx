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
CREATE TABLE yasql_ttab_0010 (
    c12c   CHAR (12 CHAR),
    c12b   CHAR (12 BYTE),
    nc12   NCHAR (12),      -- implicit 'char'
    vc12c  VARCHAR2 (12 CHAR),
    vc12b  VARCHAR2 (12 BYTE),
    nvc12  NVARCHAR2 (12)   -- implicit 'char'
);
DESCRIBE yasql_ttab_0010
DONE

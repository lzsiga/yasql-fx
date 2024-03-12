#!/bin/sh

# This script shouldn't work, as the slash after the function-definition is not in a new line

# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

set -u

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE
drop function yasql_tfun_0006;

create or replace function yasql_tfun_0006(p_chr number) return nvarchar2 is
begin
   return '['||chr(p_chr)||nchr(p_chr)||']';
end; /

select yasql_tfun_0006(167) from dual;
DONE

#!/bin/sh

# This script creates a function and a type.
# The former requires a terminator (a line containing only a slash)
# Notes:
#
# * This is not exactly Sql*Plus compatible; in Sql*Plus
#   'CREATE TYPE' also requires a terminator
#
# * Also Sql*Plus accepts another terminator: a line containing only a dot;
#   this doesn't execute the command, only stores it in a buffer,
#   a subsequent '/' or 'RUN' will execute it

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
drop function yasql_tfun_0005;

create function yasql_tfun_0005(p_chr number) return nvarchar2 is
begin
   return nchr(p_chr); /* single character */
end;
/
select yasql_tfun_0005(167) from dual;

create or replace function yasql_tfun_0005(p_chr number) return nvarchar2 is
begin
   return '['||nchr(p_chr)||']'; -- some more characters
end;
/
select yasql_tfun_0005(167) from dual;

create or replace type yasql_ttyp_0005 as
object (t_id number, t_name varchar2(64 char));

select '-- That''s "all" --' from dual;

DONE

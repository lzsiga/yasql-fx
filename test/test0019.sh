#!/bin/sh

# This test demonstrates that 'begin' in the statement doesn't always means pl/sql

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

begin dbms_output.put_line('anonymous PL/SQL block'); end;
/
prompt re-execute
/

select procedure_name from all_procedures where object_name='UTL_HTTP' and procedure_name='END_REQUEST';
select procedure_name from all_procedures where object_name='UTL_HTTP' and procedure_name='BEGIN_REQUEST';

exit
DONE

#!/bin/sh

# Testing error-indicator (<*>) placement
# The error-offset is comes from the server, it is interpreted in bytes
# according to NLS_CHARACTERSET
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

# expected output:

# SELECT 'arvizturo tukorfurogep' FROM DUALE
#                                      *
# ORA-00942: table or view does not exist (DBD ERROR:
# error possibly near <*> indicator at char 37 in
# 'SELECT 'arvizturo tukorfurogep' FROM <*>DUALE')

# SELECT 'árvíztűrő tükörfúrogép' FROM DUALE
#                                      *
# ORA-00942: table or view does not exist (DBD ERROR:
# error possibly near <*> indicator at char 37 in
# 'SELECT 'árvíztűrő tükörfúrogép' FROM <*>DUALE')

# SELECT 'árvíztűrő tükörfúrogé' FROM DUALE
#                                     *
# ORA-00942: table or view does not exist (DBD ERROR:
# error possibly near <*> indicator at char 36 in
# 'SELECT 'árvíztűrő tükörfúrogé' FROM <*>DUALE')

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE

SELECT 'arvizturo tukorfurogep' FROM DUALE;
SELECT 'árvíztűrő tükörfúrogép' FROM DUALE;
SELECT 'árvíztűrő tükörfúrogé' FROM DUALE;

SELECT
'árvíztűrő tükörfúrógép'
FROM DUALE;

exit
DONE

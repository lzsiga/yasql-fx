#!/bin/sh

# This script demonstrates a problem with some utf8-string-length-caching-magic
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

# Possible workarounds (pick one):

# 1. remove 'substr' from line 3163
# @@ -3163 +3163 @@
# -             my $data = substr($res->[$i],0,$widths[$i]);
# +             my $data = $res->[$i];

# 2. add 'undef'
# @@ -3171,2 +3171,3 @@
#               }
# +             $res->[$i]= undef;
#             }

# 3. patch 'oci8.c' in DBD-Oracle-1.83
# --- oci8.~c     2022-01-17 03:06:35.000000000 +0100
# +++ oci8.c      2024-03-03 16:23:02.000000000 +0100
# @@ -4169,7 +4169,7 @@
#                                                 while(datalen && p[datalen - 1]==' ')
#                                                         --datalen;
#                                         }
# -                                       sv_setpvn(sv, p, (STRLEN)datalen);
# +                                       sv_setpvn_mg(sv, p, (STRLEN)datalen);
#   #if DBIXS_REVISION > 13590
#                 /* If a bind type was specified we use DBI's sql_type_cast
#                         to cast it - currently only number types are handled */

if [ -z "$YaSql" ]; then
    YaSql=$(which yasql)
fi

# the problem appears only when NLS_LANG is set to AL32UTF8

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

/usr/local/bin/perl -Ca "$YaSql" $(cat ~/secret/scott.dbuid) <<DONE
SELECT 'alpha' nam FROM (SELECT LEVEL lvl FROM dual CONNECT BY LEVEL <= 1001) union all
SELECT 'bet'   nam FROM (SELECT LEVEL lvl FROM dual CONNECT BY LEVEL <= 11) union all
SELECT 'camma' nam FROM (SELECT LEVEL lvl FROM dual CONNECT BY LEVEL <= 11) order by nam;
DONE
exit

Output (original):
...
alpha
bet
bet
bet
bet
bet
bet
bet
bet
bet
bet
bet
panic: sv_len_utf8 cache 3 real 5 for camma at /usr/local/bin/yasql line 3163, <STDIN> line 3.

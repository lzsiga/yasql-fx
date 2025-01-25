#!/bin/sh

# This script demonstrates a 8-bit-compatibility problem (ISO-8859-2)
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

# Problem describtion:
# In the error-messages we expect this:
#| DECLARE
#|  -- this file is in ISO-885-2 encoding
#|  -- árvíztûrõ tükörfúrógép
#|  Some Error;
#|       *
#|END;
#
# instead we get this:
#| DECLARE
#|  -- this file is in ISO-885-2 encoding
#|  -- árvízt\x{00fb}r\x{00f5} tükörfúrógép
#|  Some Error;
#|       *
#|END;

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=hu_HU.ISO-8859-2
export NLS_LANG=american_america.EE8ISO8859P2
export NLS_NCHAR=EE8ISO8859P2
printf '\nThis test should work on 8-bit terminal (ISO-8859-2)\n\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt  $(cat ~/secret/scott.dbuid) <<DONE
@test0020.sql
exit
DONE

#!/bin/sh

# This script demonstrates utf8-compatibility
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

# This parts works best on an utf8-compatible terminal/emulator
# Note: you shouldn't see messages like this:
#   Wide character in print at /usr/local/bin/yasql line 3146, <STDIN> line 2.
#   Wide character in print at /usr/local/bin/yasql line 3146, <CONFIG> line 90.

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8
printf '\nThis test should work on utf8-compatible terminals\n'
printf 'The first one only works if NLS_CHARACTERSET is unicode compatible\n'
printf 'The next two only works if NLS_NCHAR_CHARACTERSET is unicode compatible\n'

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE
-- this only works if NLS_CHARACTERSET on the server is Unicode-compatible,
-- such as AL32UTF8
SELECT 'ΑαΒβΓγΔδΕε ЁёЖжЗзИиЙй' U FROM dual;

-- this only works if NLS_NCHAR_CHARACTERSET on the server is Unicode-compatible
-- (it usually is)
SELECT unistr('\0391\03b1\0392\03b2\0393\03b3\0394\03b4\0395\03b5\0020\0401\0451\0416\0436\0417\0437\0418\0438\0419\0439') U FROM dual;

SELECT unistr('\0391\03b1\0392\03b2\0393\03b3\0394\03b4\0395\03b5\0020\0401\0451\0416\0436\0417\0437\0418\0438\0419\0439') U
FROM dual; >tmp.utf8
! cat tmp.utf8

select nchr(219)||nchr(368) NC,unistr('\00db')||unistr('\0170') US from dual;
DONE

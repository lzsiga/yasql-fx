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

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE
-- this only works if NLS_CHARACTERSET on the server is Unicode-compatible,
-- such as AL32UTF8
SELECT 'Î‘Î±Î’Î²Î“Î³Î”Î´Î•Îµ ÐÑ‘Ð–Ð¶Ð—Ð·Ð˜Ð¸Ð™Ð¹' U FROM dual;

-- this only works if NLS_NCHAR_CHARACTERSET on the server is Unicode-compatible
-- (it usually is)
SELECT unistr('\0391\03b1\0392\03b2\0393\03b3\0394\03b4\0395\03b5\0020\0401\0451\0416\0436\0417\0437\0418\0438\0419\0439') U FROM dual;
DONE

# This parts works best on an 8-bit compatible terminal/emulator
# For the sample, I choose latin1

export LC_CTYPE=en_US.ISO-8859-1
export NLS_LANG=american_america.WE8ISO8859P1
export NLS_NCHAR=WE8ISO8859P1

"$YaSql" $(cat ~/secret/scott.dbuid) <<DONE
-- the result of this depends on NLS_CHARACTERSET (server-side) and NLS_LANG (client-side)
SELECT 'áéíóú äëîöü' X FROM dual;

-- this test uses NCHAR;
-- the result depends on NLS_NCHAR_CHARACTERSET (server-side) and NLS_NCHAR (client-side)
SELECT N'áéíóú äëîöü' X FROM dual;

-- this uses NCHAR too, also unistr with unicodes
SELECT unistr('\00e1\00e9\00ed\00f3\00fa\0020\00e4\00eb\00ee\00f6\00fc') X FROM dual;
DONE

#!/bin/sh

# Testing multiline fields
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

# Sql*Plus generates this (the field-widths seem to be overdone):
# FLD1                     FLD       NUMBEFIELD FLD4
# ------------------------ --------- ---------- ---------------------------------------
# A                        DDD            12.34 EEEE
# BB                                            FF
# CCC                                           GGGGG
#                                               HH

# We should generate thie:

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE

prompt === Multiline fields ===
SELECT 'A'||chr(10)||'BB'||chr(10)||'CCC' FLD1, 'DDD' FLD2,
   12.34 NUMBEFIELD, 'EEEE'||chr(10)||'FF'||chr(10)||'GGGGG'||chr(10)||'HH' FLD4 FROM DUAL;

exit
DONE

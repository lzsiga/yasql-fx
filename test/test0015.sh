#!/bin/sh

# Testing 'prompt' -- write to stdout

# with Sql*Plus, it prints the text without the last semicolon
# it is something like this command: sed -E 's/\s+$//; s/^(.*);$/\1/'
# mind you, semicolon doesn't terminate the command, see the last example
# also it can be abbreviated as "prom", "promp"
# the leading spaces are also trimmed (last example)
#
# νωρίς το πρωί η τσίχλα σπάνια τσίριξε
# korán reggelt ritkán rikkant a rigó
# ранним утром дрозд редко визжал;
# first; prompt second

Perl="${Perl:-$(which perl)}"
PerlOpt="${PerlOpt:-}"

YaSql="${YaSql:-$(which yasql)}"
YaSqlOpt="${YaSqlOpt:-}"

export LC_CTYPE=en_US.UTF-8
export NLS_LANG=american_america.AL32UTF8
export NLS_NCHAR=AL32UTF8

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/gyartas_test.dbuid) <<DONE
prompt νωρίς το πρωί η τσίχλα σπάνια τσίριξε   
prompt korán reggelt ritkán rikkant a rigó;
prompt ранним утром дрозд редко визжал;;
prom        first; prompt second;       
DONE

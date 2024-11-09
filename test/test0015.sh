#!/bin/sh

# Testing 'prompt' -- write to stdout

# with Sql*Plus, it prints the text without the last semicolon
# it is something like this command: sed -E 's/\s+$//; s/^(.*);$/\1/'
# mind you, semicolon doesn't terminate the command, see the last example
# also it can be abbreviated as "prom", "promp"
# the leading spaces are also trimmed (last example)
# To run it, create a file called ~/secret/scott.dbuid than contains a
# valid user/password@tns sequence, e.g. scott/tiger@orcl

# expected output (from Sql*Plus)
# Now some empty lines
# <empty line>
# <empty line>
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

"$Perl" $PerlOpt "$YaSql" $YaSqlOpt $(cat ~/secret/scott.dbuid) <<DONE
prompt Now some empty lines
prompt
prompt;
prompt νωρίς το πρωί η τσίχλα σπάνια τσίριξε   
prompt korán reggelt ritkán rikkant a rigó;
prompt ранним утром дрозд редко визжал;;
prom        first; prompt second;       
DONE

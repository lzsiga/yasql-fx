#!/usr/local/bin/perl

use strict;
use warnings;
use utf8;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode is_utf8);

sub is_ascii {
    my $s= $_[0];

    my $regex= '^[\\p{ASCII}]*$';
    return $s =~ /$regex/;
}

sub error_indicator_hack {
    my $errmsg= $_[0];
    my $srv_charset= $_[1];

    my $ptn = '^(.*)(at\ char\ )(\d+)( in \')(.*)\'\)$';
    if ($errmsg !~ m/$ptn/s) {
        printf("Pattern '%s' didn't match\n", $ptn);
        return (0, $errmsg);
    }
    my $start= $1;
    my $indicator_offset= $3;
    my $rest = $5;
    my $pos= index($rest, '<*>');

    if (is_ascii($rest) || $srv_charset eq 'AL32UTF8') {
#       printf('Server is utf8: offset to be corrected, indicator is on the right place'."\n");
        $indicator_offset= $pos;
    } else {
#       printf('Server is singlebyte: offset is correct [chars], indicator to be moved'."\n");
        my $pos= index($rest, '<*>');
        if ($pos >= 0) {
            substr($rest, $pos, 3, '');
            if (!is_utf8($rest)) {
                my $tmp= decode('UTF-8', $rest, Encode::FB_DEFAULT);
                if ($tmp && is_utf8($tmp)) {
                    $rest= $tmp;
                }
            }
            substr($rest, $indicator_offset, 0, '<*>');
        }
        printf('Modified: %s'."\n", $rest);
    }
    return ($indicator_offset, $start.'at char '.$indicator_offset." in '".$rest."')");
}

sub Test1 {
    my $testname= $_[0];
    my $teststr= $_[1];
    my $srv_charset= $_[2];
    printf("\n=== Test '%s', servercharset '%s' ===\n", $testname, $srv_charset);
    printf("Input: %s\nis_utf8=%d\n", $teststr, is_utf8($teststr));
    my ($erroffs, $retstr)= error_indicator_hack($teststr, $srv_charset);
    printf("Error offset: %d\n", $erroffs);
    printf("New str: %s\n", $retstr);
}

my $testuni1=
    "ORA-00942: table or view does not exist".
    " (DBD ERROR: error possibly near <*> indicator at char 46".
    " in 'select 'árvíztűrő tükörfúrógép' from <*>duale')";

my $testuni2=
   "ORA-00942: table or view does not exist".
   " (DBD ERROR: error possibly near <*> indicator at char 36".
   " in 'select 'arvizturo tukorfuroge' from <*>duale')";

my $testuni3=
   "ORA-00942: table or view does not exist".
   " (DBD ERROR: error possibly near <*> indicator at char 46".
   " in 'select 'árvíztűrő tükörfúrógép'\n".
   " from <*>duale')";

my $test8bit1; # special case: the <*> indicator is inserted inside an UTF8 sequence
{ no utf8;
  $test8bit1=
    "ORA-00942: table or view does not exist".
    " (DBD ERROR: error possibly near <*> indicator at char 37".
    " in 'select 'árvíztűrő tükörfúróg\xc3<*>\xa9p' from duale')";
}

my $test8bit2=
   "ORA-00942: table or view does not exist".
   " (DBD ERROR: error possibly near <*> indicator at char 36".
   " in 'select 'árvíztűrő tükörfúróg<*>é' from duale')";

my $test8bit3=
   "ORA-00942: table or view does not exist".
   " (DBD ERROR: error possibly near <*> indicator at char 36".
   " in 'select 'arvizturo tukorfuroge' from <*>duale')";

Test1('testuni1',  $testuni1,  'AL32UTF8');
Test1('testuni2',  $testuni2,  'AL32UTF8');
Test1('testuni3',  $testuni3,  'AL32UTF8');
Test1('test8bit1', $test8bit1, 'EE8ISO8859P2');
Test1('test8bit2', $test8bit2, 'EE8ISO8859P2');
Test1('test8bit3', $test8bit3, 'EE8ISO8859P2');
Test1('inperr1', 'inperr1', 'EE8ISO8859P2');

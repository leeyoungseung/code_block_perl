#!/usr/bin/perl
use strict; 
use warnings;
use Cwd;
use Config;


###############################
###########   Main   ##########
###############################
my $reg1 = "dav";
my $reg2 = "[Dd]avid"; # Can match David and david
my $reg3 = "tig[eE][rR]"; # Can match (tiger, tigeR, tigEr, tigER)
my $reg4 = "[0-9]"; # Can match (0123456789)
my $reg5 = "[a-z]"; # Can match only lower eng
my $reg6 = "[a-zA-Z0-9]"; # Can match any of the above
my $reg7 = "[^a-z]";  # Can match anything other than lower eng.
my $reg8 = "[0-9]{10}"; # Can match number only length 10.
my $reg9 = "[a-z0-9]{8,12}"; # Can match lower eng and number length : from 8 to 12
my $reg10 = "david|tiger"; # Can match 'david' or 'tiger'
my $reg11 = "david(1|2)"; # Can match 'david1' or 'david2'
my $reg12 = "david(!+|\?)"; # Can match david followed by one or more ! or one ?
my $reg13 = "^tig"; # Can match start of 'tig'
my $reg14 = "tig$"; # Can match end of 'tig'

my $str1 = "david1";
my $str2 = "tiger1";

print matchRegExp($str1, $reg1) . "\n";
print matchRegExp($str2, $reg1) . "\n";



###############################
########### Function ##########
###############################



# res : 0(true), 1(false)
sub matchRegExp {
    my ($target,$matcher) = @_;
    print "matchRegExp\n";

    if ($matcher eq '' | $target eq '') {
        print "param is null\n";
    }

    my $res = 0;
    if ($target =~ /$matcher/) {
        print "------ target is match ------\n";
        print "target : [$target] , regexp : [$matcher] \n";
    } else {
        print "------ target is not match ------\n";
        print "target : [$target] , regexp : [$matcher] \n";
        $res = 1;
    }
    return $res;
}



#!/usr/bin/perl
use strict; 
use warnings;

# condition of count
my $num1 = 100;
my $num2 = 50;
my $num3 = 100;

# value for condition of string
my $str1 = "David";
my $str2 = "Tiger1234";
my $str3 = "Hell and Heaven";
my $str4 = "";
###############################
###########   Main   ##########
############################### 
isEqual($num1,$num2);
isEqual($num1,$num3);

isNotEqual($num1,$num2);

isLittleInt($num2,$num1);
isLittleInt($num1,$num3);

isLittleOrEqualInt($num2,$num1);
isLittleOrEqualInt($num1,$num3);

isGreaterInt($num1,$num2);
isGreaterInt($num1,$num3);

isGreaterOrEqualInt($num1,$num2);
isGreaterOrEqualInt($num1,$num3);

isEqual($str1,$str1);
isEqual($str1,$str2);

isNotEqual($str1,$str3);

###############################
########### Function ##########
###############################

sub isGreaterOrEqualInt { # ge ( >= )
    my ($num1,$num2) = @_;

    print "isGreaterOrEqual()\n"; 
    if ($num1 >= $num2) {
        print "[$num1] >= [$num2]\n";
    } else {
        print "[$num1] < [$num2]\n";
    }

    
    if ($num1 ge $num2) {
        print "[$num1] ge [$num2]\n";
    } else {
        print "[$num1] lt [$num2]\n";
    }

}

sub isGreaterInt { # gt ( > )
    my ($num1,$num2) = @_;

    print "isGreater()\n"; 
    if ($num1 > $num2) {
        print "[$num1] > [$num2]\n";
    } else {
        print "[$num1] <= [$num2]\n";
    }

    
    if ($num1 gt $num2) {
        print "[$num1] gt [$num2]\n";
    } else {
        print "[$num1] le [$num2]\n";
    }

}

sub isLittleOrEqualInt { # le : ( <= )
    my ($num1,$num2) = @_;

    print "isLittleOREqual()\n"; 
    if ($num1 <= $num2) {
        print "[$num1] <= [$num2]\n";
    } else {
        print "[$num1] >= [$num2]\n";
    }

    
    if ($num1 le $num2) {
        print "[$num1] le [$num2]\n";
    } else {
        print "[$num1] gt [$num2]\n";
    }

}

sub isLittleInt { # lt : ( < )
    my ($num1,$num2) = @_;

    print "isLittle()\n"; 
    if ($num1 < $num2) {
        print "[$num1] < [$num2]\n";
    } else {
        print "[$num1] > [$num2]\n";
    }

    
    if ($num1 lt $num2) {
        print "[$num1] lt [$num2]\n";
    } else {
        print "[$num1] gt OR ge [$num2]\n";
    }

}

sub isEqual{ # eq (==)
    my ($num1,$num2) = @_;

    print "isEqualInt()\n"; 
    if ($num1 == $num2) { # This one can't use string
        print "equal [$num1] == [$num2]\n";
    } else {
        print "Not equal [$num1] != [$num2]\n";
    }

    if ($num1 eq $num2) {
        print "equal [$num1] eq [$num2]\n";
    } else {
        print "Not equal [$num1] ne [$num2]\n";
    }
}


sub isNotEqual { # ne (!=)
    my ($num1,$num2) = @_;

    print "isNotEqualInt()\n"; 
    if ($num1 != $num2) { # This one can't use string
        print "Not equal [$num1] != [$num2]\n";
    } else {
        print "equal [$num1] == [$num2]\n";
    }

    if ($num1 ne $num2) {
        print "Not equal [$num1] ne [$num2]\n";
    } else {
        print "equal [$num1] eq [$num2]\n";
    }
}


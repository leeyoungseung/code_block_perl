#!/usr/bin/perl
use strict; 
use warnings;
use LWP::UserAgent; # yum install perl perl-libwww-perl

###############################
###########   Main   ##########
###############################
my $testGetUrl = "http://127.0.0.1/index.html";
requestGet($testGetUrl);

my $testPostUrl = "http://127.0.0.1/postTest.php";
requestPost($testPostUrl, );




###############################
########### Function ##########
###############################

sub requestGet {
    my ($url) = @_;
    print "requestGet\n";

    if ($url eq '' || $url !~ /http[s]?/ ){
        print "param is null or fail matching pattern \n";
    }

    my $ua = LWP::UserAgent -> new;
    my $response = $ua -> get($url);

    if ($response -> is_success) {
        print $response -> decoded_content;
        print "\n";
    } else {
        print $response -> status_line;
        print "\n";
    }
}

